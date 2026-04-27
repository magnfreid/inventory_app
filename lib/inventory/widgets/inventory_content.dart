import 'package:app_ui/app_ui.dart';
import 'package:core_remote/core_remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_part_card.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/part_filtering_extension.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/shared/utilities/bone_mocks.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// The scrollable parts list and filter controls.
///
/// Shared between compact and expanded layouts — width constraints are applied
/// by the parent, not here.
class InventoryContent extends StatelessWidget {
  /// Creates an [InventoryContent].
  const InventoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<InventoryBloc, InventoryState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final error = state.error;
        if (error != null) context.showErrorSnackBar(error);
      },
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final error = state.error;
          final parts =
              state.isLoading ? boneMockParts : state.filteredParts;
          return Padding(
            padding: const .symmetric(horizontal: 8),
            child: Column(
              children: [
                if (error != null && error is NetworkException)
                  Row(
                    children: [
                      const Padding(
                        padding: .symmetric(horizontal: 8, vertical: 4),
                        child: Icon(Icons.warning, color: Colors.yellow),
                      ),
                      Text(error.toL10n(context)),
                    ],
                  ),
                Padding(
                  padding: const .symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Text('${l10n.showing}:'),
                          Text(state.filteredParts.length.toString()),
                          Text(
                            '(${l10n.ofText} ${state.parts.length})',
                            style: TextStyle(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(l10n.inventoryShowEmptyStockText),
                          ScaleTransition(
                            scale: const AlwaysStoppedAnimation(0.6),
                            child: Switch(
                              value:
                                  state.filter.quantityFilter == .inStock,
                              onChanged: (_) =>
                                  context.read<InventoryBloc>().add(
                                    const HideEmptyStockSwitchPressed(),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Skeletonizer(
                    enabled: state.isLoading,
                    child: parts.isEmpty
                        ? Center(child: Text(l10n.partsListEmpty))
                        : ListView.builder(
                            padding: const .only(bottom: 140),
                            itemCount: parts.length,
                            itemBuilder: (context, index) =>
                                InventoryPartCard(part: parts[index]),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
