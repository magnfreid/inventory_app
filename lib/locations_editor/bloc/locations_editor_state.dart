import 'package:freezed_annotation/freezed_annotation.dart';

part 'locations_editor_state.freezed.dart';

enum LocationEditorStatus { idle, loading, success }

@freezed
abstract class LocationsEditorState with _$LocationsEditorState {
  const factory LocationsEditorState({
    @Default(LocationEditorStatus.idle) LocationEditorStatus status,
  }) = _LocationEditorState;

  const LocationsEditorState._();

  bool get isLoading => status == .loading;
  bool get isSuccess => status == .success;
}
