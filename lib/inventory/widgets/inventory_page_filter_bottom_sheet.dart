import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/list_sorting_extension.dart';

class InventoryPageFilterBottomSheet extends StatelessWidget {
  const InventoryPageFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        final filter = state.filter;
        final bloc = context.read<InventoryBloc>();
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.7,
            child: SingleChildScrollView(
              child: Padding(
                padding: const .fromLTRB(24, 0, 24, 24),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          l10n.filterSheetTitleText,
                          style: context.text.bodyLarge?.copyWith(
                            fontWeight: .bold,
                          ),
                        ),
                        AppButton.text(
                          onPressed: () =>
                              bloc.add(const ClearAllFiltersButtonPressed()),
                          label:
                              '${l10n.filterSheetClearAllText} '
                              '(${filter.totalActiveFilters})',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(l10n.inventoryShowEmptyStockText),
                        ScaleTransition(
                          scale: const AlwaysStoppedAnimation(0.8),
                          child: Switch(
                            value: state.filter.quantityFilter == .inStock,
                            onChanged: (_) =>
                                bloc.add(const HideEmptyStockSwitchPressed()),
                          ),
                        ),
                      ],
                    ),
                    Text(l10n.formFieldCategoryLabelText),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: Text(l10n.all),
                          selected: state.filter.categoryFilters.isEmpty,
                          onSelected: (selected) {
                            bloc.add(
                              const ClearFilterChipPressed(type: .category),
                            );
                          },
                        ),
                        ...state.categoryTags.sortedByLabel().map(
                          (tag) => FilterChip(
                            showCheckmark: false,
                            selected: state.filter.categoryFilters.contains(
                              tag.id,
                            ),
                            label: Text(tag.label),
                            onSelected: (selected) {
                              bloc.add(
                                FilterChipPressed(
                                  type: .category,
                                  itemId: tag.id,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(l10n.brand),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: Text(l10n.all),
                          selected: filter.brandFilters.isEmpty,
                          onSelected: (selected) {
                            bloc.add(
                              const ClearFilterChipPressed(type: .brand),
                            );
                          },
                        ),
                        ...state.brandTags.sortedByLabel().map(
                          (tag) => FilterChip(
                            showCheckmark: false,
                            label: Text(tag.label),
                            selected: filter.brandFilters.contains(tag.id),
                            onSelected: (selected) {
                              bloc.add(
                                FilterChipPressed(type: .brand, itemId: tag.id),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(l10n.storage),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          selected: filter.storageFilters.isEmpty,
                          label: Text(l10n.all),
                          onSelected: (selection) {
                            bloc.add(
                              const ClearFilterChipPressed(type: .storage),
                            );
                          },
                        ),
                        ...state.storages.sortedByName().map(
                          (storage) => FilterChip(
                            showCheckmark: false,
                            label: Text(storage.name),
                            selected: filter.storageFilters.contains(
                              storage.id,
                            ),
                            onSelected: (selection) {
                              bloc.add(
                                FilterChipPressed(
                                  type: .storage,
                                  itemId: storage.id ?? '',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
