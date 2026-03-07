final class InventoryFilter {
  const InventoryFilter({
    this.quantityFilter = .all,
    this.brandFilters = const {},
    this.categoryFilters = const {},
    this.storageFilters = const {},
  });

  final QuantityFilter quantityFilter;
  final Set<String> brandFilters;
  final Set<String> categoryFilters;
  final Set<String> storageFilters;

  int get totalActiveFilters =>
      brandFilters.length + categoryFilters.length + storageFilters.length;

  InventoryFilter copyWith({
    QuantityFilter? quantityFilter,
    Set<String>? brandFilters,
    Set<String>? categoryFilters,
    Set<String>? storageFilters,
  }) => InventoryFilter(
    quantityFilter: quantityFilter ?? this.quantityFilter,
    brandFilters: brandFilters ?? this.brandFilters,
    categoryFilters: categoryFilters ?? this.categoryFilters,
    storageFilters: storageFilters ?? this.storageFilters,
  );
}

enum QuantityFilter { all, inStock, outOfStock }
