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

final class FilterChipPressed extends InventoryEvent {
  const FilterChipPressed({required this.type, required this.itemId});
  final InventoryFilterType type;
  final String itemId;
}

final class ClearFilterChipPressed extends InventoryEvent {
  const ClearFilterChipPressed({required this.type});
  final InventoryFilterType type;
}

final class ClearAllFiltersButtonPressed extends InventoryEvent {
  const ClearAllFiltersButtonPressed();
}

final class HideEmptyStockSwitchPressed extends InventoryEvent {
  const HideEmptyStockSwitchPressed();
}
