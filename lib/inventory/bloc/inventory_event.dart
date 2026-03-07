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

final class _StoragesUpdated extends InventoryEvent {
  const _StoragesUpdated({required this.storages});
  final List<Storage> storages;
}

final class UseStockButtonPressed extends InventoryEvent {
  const UseStockButtonPressed({required this.partId, required this.storageId});
  final String partId;
  final String storageId;
}

final class HideEmptyStockSwitchPressed extends InventoryEvent {
  const HideEmptyStockSwitchPressed();
}

final class ClearBrandFilterChipPressed extends InventoryEvent {
  const ClearBrandFilterChipPressed();
}

final class BrandFilterChipPressed extends InventoryEvent {
  const BrandFilterChipPressed({required this.tagId});
  final String tagId;
}

final class ClearCategoryFilterChipPressed extends InventoryEvent {
  const ClearCategoryFilterChipPressed();
}

final class CategoryFilterChipPressed extends InventoryEvent {
  const CategoryFilterChipPressed({required this.categoryId});
  final String categoryId;
}

final class StorageFilterChipPressed extends InventoryEvent {
  const StorageFilterChipPressed({required this.storageId});
  final String storageId;
}

final class ClearStorageFilterChipPressed extends InventoryEvent {
  const ClearStorageFilterChipPressed();
}

final class ClearAllFiltersButtonPressed extends InventoryEvent {
  const ClearAllFiltersButtonPressed();
}
