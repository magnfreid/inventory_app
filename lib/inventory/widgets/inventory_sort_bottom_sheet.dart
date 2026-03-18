import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/sort_by_extensions.dart';

class InventorySortBottomSheet extends StatelessWidget {
  const InventorySortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const .fromLTRB(16, 0, 16, 36),
            child: Column(
              spacing: 10,
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                const SizedBox(width: double.infinity),
                Text(
                  l10n.sortSheetTitleText,
                  style: context.text.bodyLarge?.copyWith(fontWeight: .bold),
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ...SortByType.values.map(
                      (type) => FilterChip(
                        selected: type == state.filter.sortByType,
                        label: Text(type.toL10n(context)),
                        onSelected: (_) => context.read<InventoryBloc>().add(
                          SortByChipPressed(sortBy: type),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
