part of 'locations_editor_bloc.dart';

sealed class LocationsEditorEvent {
  const LocationsEditorEvent();
}

final class SaveButtonPressed extends LocationsEditorEvent {
  const SaveButtonPressed({required this.createModel});
  final LocationCreateModel createModel;
}
