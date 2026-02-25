import 'package:freezed_annotation/freezed_annotation.dart';

part 'storages_editor_state.freezed.dart';

enum StoragesEditorStatus { idle, loading, success }

@freezed
abstract class StoragesEditorState with _$StoragesEditorState {
  const factory StoragesEditorState({
    @Default(StoragesEditorStatus.idle) StoragesEditorStatus status,
  }) = _StoragesEditorState;

  const StoragesEditorState._();

  bool get isLoading => status == .loading;
  bool get isSuccess => status == .success;
}
