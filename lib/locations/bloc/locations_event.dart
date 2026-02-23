part of 'locations_bloc.dart';

sealed class LocationsEvent {
  const LocationsEvent();
}

final class _LocationsListUpdated extends LocationsEvent {
  const _LocationsListUpdated({required this.locations});
  final List<Location> locations;
}
