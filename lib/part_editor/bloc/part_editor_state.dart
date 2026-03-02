import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tag_repository/tag_repository.dart';

part 'part_editor_state.freezed.dart';

enum PartEditorStatus { idle, loading, success, error }

@freezed
abstract class PartEditorState with _$PartEditorState {
  const factory PartEditorState({
    @Default(PartEditorStatus.idle) PartEditorStatus status,
    @Default([]) List<Tag> mainTags,
  }) = _PartEditorState;
  const PartEditorState._();

  bool get isLoading => status == .loading;
  bool get isSuccess => status == .success;
}
