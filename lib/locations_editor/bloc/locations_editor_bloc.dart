import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/locations_editor/bloc/locations_editor_state.dart';
import 'package:location_repository/location_repository.dart';

part 'locations_editor_event.dart';

class LocationsEditorBloc
    extends Bloc<LocationsEditorEvent, LocationsEditorState> {
  LocationsEditorBloc({required LocationRepository locationRepository})
    : _locationRepository = locationRepository,
      super(const LocationsEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  final LocationRepository _locationRepository;

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<LocationsEditorState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _locationRepository.add(locationCreateModel: event.createModel);
      emit(state.copyWith(status: .success));
    } on Exception catch (_) {}
  }
}
