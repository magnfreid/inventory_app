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
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: SingleChildScrollView(
              child: Padding(
                padding: const .fromLTRB(24, 0, 24, 24),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Filter by',
                      style: context.text.bodyLarge?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                    const Text('Stock:'),
                    Wrap(
                      spacing: 10,
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: filter.quantityFilter == .all,
                          onSelected: (value) {
                            context.read<InventoryBloc>().add(
                              const QuantityFilterChipPressed(
                                quantityFilter: .all,
                              ),
                            );
                          },
                        ),
                        FilterChip(
                          showCheckmark: false,
                          selected: filter.quantityFilter == .inStock,
                          label: const Text('In stock'),
                          onSelected: (value) {
                            context.read<InventoryBloc>().add(
                              const QuantityFilterChipPressed(
                                quantityFilter: .inStock,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Text('Category:'),
                    Wrap(
                      spacing: 10,
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: state.filter.categoryFilters.isEmpty,
                          onSelected: (selected) {
                            context.read<InventoryBloc>().add(
                              const ClearCategoryFilterChipPressed(),
                            );
                          },
                        ),
                        ...state.categoryTags.map(
                          (tag) => FilterChip(
                            showCheckmark: false,
                            selected: state.filter.categoryFilters.contains(
                              tag,
                            ),
                            label: Text(tag.label),
                            onSelected: (selected) {
                              context.read<InventoryBloc>().add(
                                CategoryFilterChipPressed(categoryTag: tag),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Text('Brand:'),
                    Wrap(
                      spacing: 10,
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: filter.brandFilters.isEmpty,
                          onSelected: (selected) {
                            context.read<InventoryBloc>().add(
                              const ClearBrandFilterChipPressed(),
                            );
                          },
                        ),
                        ...state.brandTags.map(
                          (tag) => FilterChip(
                            showCheckmark: false,
                            label: Text(tag.label),
                            selected: filter.brandFilters.contains(tag),
                            onSelected: (selected) {
                              context.read<InventoryBloc>().add(
                                BrandFilterChipPressed(brandTag: tag),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Text('Storage:'),
                    Wrap(
                      spacing: 10,
                      children: [
                        FilterChip(
                          selected: filter.storageFilters.isEmpty,
                          label: const Text('All'),
                          onSelected: (selection) {},
                        ),
                        ...state.storages.map(
                          (storage) => FilterChip(
                            showCheckmark: false,
                            label: Text(storage.name),
                            selected: filter.storageFilters.contains(storage),
                            onSelected: (selection) {
                              context.read<InventoryBloc>().add(
                                StorageFilterChipPressed(storage: storage),
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
