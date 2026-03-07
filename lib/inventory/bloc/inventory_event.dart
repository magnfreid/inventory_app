part of 'inventory_bloc.dart';

sealed class InventoryEvent {
  const InventoryEvent();
}

final class _PartsUpdated extends InventoryEvent {
  const _PartsUpdated({required this.parts});
  final List<PartPresentation> parts;
}

final class _TagsUpdated extends InventoryEvent {
  const _TagsUpdated({required this.tags});
  final List<TagPresentation> tags;
}

final class UseStockButtonPressed extends InventoryEvent {
  const UseStockButtonPressed({required this.partId, required this.storageId});
  final String partId;
  final String storageId;
}

final class QuantityFilterChipPressed extends InventoryEvent {
  const QuantityFilterChipPressed({required this.quantityFilter});
  final QuantityFilter quantityFilter;
}

final class ClearBrandFilterChipPressed extends InventoryEvent {
  const ClearBrandFilterChipPressed();
}

final class BrandFilterChipPressed extends InventoryEvent {
  const BrandFilterChipPressed({required this.brandTag});
  final TagPresentation brandTag;
}

final class ClearCategoryFilterChipPressed extends InventoryEvent {
  const ClearCategoryFilterChipPressed();
}

final class CategoryFilterChipPressed extends InventoryEvent {
  const CategoryFilterChipPressed({required this.categoryTag});
  final TagPresentation categoryTag;
}
