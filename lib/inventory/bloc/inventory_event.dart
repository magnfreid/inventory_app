part of 'inventory_bloc.dart';

sealed class InventoryEvent {
  const InventoryEvent();
}

final class _PartsUpdated extends InventoryEvent {
  const _PartsUpdated({required this.parts});
  final List<PartPresentation> parts;
}

final class _OnStreamError extends InventoryEvent {
  const _OnStreamError({required this.error});
  final RemoteException error;
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

final class SearchQueryUpdated extends InventoryEvent {
  const SearchQueryUpdated({required this.searchString});
  final String searchString;
}

final class SortByChipPressed extends InventoryEvent {
  const SortByChipPressed({required this.sortBy});
  final SortByType sortBy;
}

final class SortOrderButtonPressed extends InventoryEvent {
  const SortOrderButtonPressed();
}
