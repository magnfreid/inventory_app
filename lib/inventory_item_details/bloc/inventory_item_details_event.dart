part of 'inventory_item_details_bloc.dart';

sealed class InventoryItemDetailsEvent {
  const InventoryItemDetailsEvent();
}

final class _LocationsUpdated extends InventoryItemDetailsEvent {
  _LocationsUpdated({required this.locations});
  final List<Location> locations;
}

final class ShowAddViewButtonPressed extends InventoryItemDetailsEvent {
  const ShowAddViewButtonPressed();
}
