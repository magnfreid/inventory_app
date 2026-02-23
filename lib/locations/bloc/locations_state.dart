import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_repository/location_repository.dart';

part 'locations_state.freezed.dart';

enum LocationsStateStatus { loading, loaded }

@freezed
abstract class LocationsState with _$LocationsState {
  const factory LocationsState({
    @Default(LocationsStateStatus.loading) LocationsStateStatus status,
    @Default([]) List<Location> locations,
  }) = _LocationsState;
  const LocationsState._();
}
