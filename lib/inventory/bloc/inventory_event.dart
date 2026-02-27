part of 'inventory_bloc.dart';

sealed class InventoryEvent {
  const InventoryEvent();
}

final class _PartsUpdated extends InventoryEvent {
  const _PartsUpdated({required this.parts});
  final List<PartUiModel> parts;
}

final class UseStockButtonPressed extends InventoryEvent {
  const UseStockButtonPressed({required this.partId, required this.storageId});
  final String partId;
  final String storageId;
}
