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
        return Padding(
          padding: const .fromLTRB(8, 0, 8, 24),
          child: Column(
            mainAxisSize: .min,
            children: [
              Text('Filter parts', style: context.text.bodyLarge),
              const SizedBox(
                width: double.infinity,
              ),
              const Text('Stock'),
              Wrap(
                spacing: 10,
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: filter.quantityFilter == .all,
                    onSelected: (value) {
                      context.read<InventoryBloc>().add(
                        const QuantityFilterChipPressed(quantityFilter: .all),
                      );
                    },
                  ),
                  FilterChip(
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
              const Text('Categories'),
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
                      selected: state.filter.categoryFilters.contains(tag),
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
              const Text('Brands'),
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
            ],
          ),
        );
      },
    );
  }
}
