import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

final class InventoryFilter {
  const InventoryFilter({
    this.quantityFilter = .all,
    this.brandFilters = const {},
    this.categoryFilters = const {},
    this.storageFilters = const {},
  });

  final QuantityFilter quantityFilter;
  final Set<TagPresentation> brandFilters;
  final Set<TagPresentation> categoryFilters;
  final Set<Storage> storageFilters;

  InventoryFilter copyWith({
    QuantityFilter? quantityFilter,
    Set<TagPresentation>? brandFilters,
    Set<TagPresentation>? categoryFilters,
    Set<Storage>? storageFilters,
  }) => InventoryFilter(
    quantityFilter: quantityFilter ?? this.quantityFilter,
    brandFilters: brandFilters ?? this.brandFilters,
    categoryFilters: categoryFilters ?? this.categoryFilters,
    storageFilters: storageFilters ?? this.storageFilters,
  );
}

enum QuantityFilter { all, inStock, outOfStock }
