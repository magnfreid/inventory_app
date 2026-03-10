enum QuantityFilter { all, inStock, outOfStock }

enum SortByType { name, brand, category, quantity }

final class InventoryFilter {
  const InventoryFilter({
    this.quantityFilter = .all,
    this.brandFilters = const {},
    this.categoryFilters = const {},
    this.storageFilters = const {},
    this.searchQuery = '',
    this.sortByType = .name,
    this.isSortedAscending = true,
  });

  final QuantityFilter quantityFilter;
  final Set<String> brandFilters;
  final Set<String> categoryFilters;
  final Set<String> storageFilters;
  final String searchQuery;
  final SortByType sortByType;
  final bool isSortedAscending;

  int get totalActiveFilters =>
      brandFilters.length + categoryFilters.length + storageFilters.length;

  InventoryFilter copyWith({
    QuantityFilter? quantityFilter,
    Set<String>? brandFilters,
    Set<String>? categoryFilters,
    Set<String>? storageFilters,
    String? searchQuery,
    SortByType? sortByType,
    bool? isSortedAscending,
  }) => InventoryFilter(
    quantityFilter: quantityFilter ?? this.quantityFilter,
    brandFilters: brandFilters ?? this.brandFilters,
    categoryFilters: categoryFilters ?? this.categoryFilters,
    storageFilters: storageFilters ?? this.storageFilters,
    searchQuery: searchQuery ?? this.searchQuery,
    sortByType: sortByType ?? this.sortByType,
    isSortedAscending: isSortedAscending ?? this.isSortedAscending,
  );
}
