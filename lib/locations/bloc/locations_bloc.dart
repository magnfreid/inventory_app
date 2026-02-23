import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/locations/bloc/locations_state.dart';
import 'package:location_repository/location_repository.dart';

part 'locations_event.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc({required LocationRepository locationRepository})
    : _locationRepository = locationRepository,
      super(const LocationsState()) {
    on<_LocationsListUpdated>(_onLocationsChanged);

    _streamSubscription = _locationRepository.watchLocations().listen(
      (data) => add(_LocationsListUpdated(locations: data)),
    );
  }

  final LocationRepository _locationRepository;
  late final StreamSubscription<List<Location>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onLocationsChanged(
    _LocationsListUpdated event,
    Emitter<LocationsState> emit,
  ) {
    emit(state.copyWith(status: .loaded, locations: event.locations));
  }
}
