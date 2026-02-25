part of 'inventory_bloc.dart';

sealed class InventoryEvent {
  const InventoryEvent();
}

final class _PartsUpdated extends InventoryEvent {
  const _PartsUpdated({required this.parts});
  final List<PartUiModel> parts;
}
