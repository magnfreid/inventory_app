part of 'inventory_bloc.dart';

sealed class InventoryEvent {
  const InventoryEvent();
}

final class _InventoryListUpdated extends InventoryEvent {
  const _InventoryListUpdated({required this.items});
  final List<InventoryItemUiModel> items;
}
