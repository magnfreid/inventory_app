part of 'storages_bloc.dart';

sealed class LocationsEvent {
  const LocationsEvent();
}

final class _StoragesUpdated extends LocationsEvent {
  const _StoragesUpdated({required this.storages});
  final List<Storage> storages;
}
