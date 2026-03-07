import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';

class InventoryPageFilterBottomSheet extends StatelessWidget {
  const InventoryPageFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                          'Filter by',
                          style: context.text.bodyLarge?.copyWith(
                            fontWeight: .bold,
                          ),
                        ),
                        AppButton.text(
                          onPressed: () =>
                              bloc.add(const ClearAllFiltersButtonPressed()),
                          label: 'Clear all (${filter.totalActiveFilters})',
                        ),
                      ],
                    ),
                    const Text('Category:'),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: state.filter.categoryFilters.isEmpty,
                          onSelected: (selected) {
                            bloc.add(const ClearCategoryFilterChipPressed());
                          },
                        ),
                        ...state.categoryTags.map(
                          (tag) => FilterChip(
                            showCheckmark: false,
                            selected: state.filter.categoryFilters.contains(
                              tag.id,
                            ),
                            label: Text(tag.label),
                            onSelected: (selected) {
                              bloc.add(
                                CategoryFilterChipPressed(categoryId: tag.id),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Text('Brand:'),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: filter.brandFilters.isEmpty,
                          onSelected: (selected) {
                            bloc.add(const ClearBrandFilterChipPressed());
                          },
                        ),
                        ...state.brandTags.map(
                          (tag) => FilterChip(
                            showCheckmark: false,
                            label: Text(tag.label),
                            selected: filter.brandFilters.contains(tag.id),
                            onSelected: (selected) {
                              bloc.add(BrandFilterChipPressed(tagId: tag.id));
                            },
                          ),
                        ),
                      ],
                    ),
                    const Text('Storage:'),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          selected: filter.storageFilters.isEmpty,
                          label: const Text('All'),
                          onSelected: (selection) {
                            bloc.add(const ClearStorageFilterChipPressed());
                          },
                        ),
                        ...state.storages.map(
                          (storage) => FilterChip(
                            showCheckmark: false,
                            label: Text(storage.name),
                            selected: filter.storageFilters.contains(
                              storage.id,
                            ),
                            onSelected: (selection) {
                              bloc.add(
                                StorageFilterChipPressed(storageId: storage.id),
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
