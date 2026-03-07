import 'package:inventory_app/tags/models/tag_presentation.dart';

final class InventoryFilter {
  const InventoryFilter({
    this.quantityFilter = .all,
    this.brandFilters = const {},
    this.categoryFilters = const {},
  });

  final QuantityFilter quantityFilter;
  final Set<TagPresentation> brandFilters;
  final Set<TagPresentation> categoryFilters;

  InventoryFilter copyWith({
    QuantityFilter? quantityFilter,
    Set<TagPresentation>? brandFilters,
    Set<TagPresentation>? categoryFilters,
  }) => InventoryFilter(
    quantityFilter: quantityFilter ?? this.quantityFilter,
    brandFilters: brandFilters ?? this.brandFilters,
    categoryFilters: categoryFilters ?? this.categoryFilters,
  );
}

enum QuantityFilter { all, inStock, outOfStock }
