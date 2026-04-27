import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/list_sorting_extension.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:inventory_app/storages/view/storages_page.dart';

/// Embedded storages panel for the expanded web layout.
///
/// Renders the storages list without a [Scaffold], using the [StoragesBloc]
/// provided by the ancestor inventory page.
class InventoryStoragesPanel extends StatelessWidget {
  /// Creates an [InventoryStoragesPanel].
  const InventoryStoragesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<StoragesBloc, StoragesState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final error = state.error;
        if (error != null) context.showErrorSnackBar(error);
      },
      child: BlocBuilder<StoragesBloc, StoragesState>(
        builder: (context, state) {
          final sorted = state.storages.sortedByName();
          return switch (state.status) {
            .loading => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            .loaded => sorted.isEmpty
                ? Center(child: Text(l10n.storage))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: sorted.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (_, index) =>
                        StorageCard(storage: sorted[index]),
                  ),
          };
        },
      ),
    );
  }
}
