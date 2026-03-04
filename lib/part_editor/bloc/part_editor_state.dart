import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';

part 'part_editor_state.freezed.dart';

enum PartEditorStatus { idle, loading, success, error }

@freezed
abstract class PartEditorState with _$PartEditorState {
  const factory PartEditorState({
    @Default(PartEditorStatus.idle) PartEditorStatus status,
    @Default([]) List<TagPresentation> brandTags,
    @Default([]) List<TagPresentation> categoryTags,
    @Default([]) List<TagPresentation> generalTags,
  }) = _PartEditorState;
  const PartEditorState._();

  bool get isLoading => status == .loading;
  bool get isSuccess => status == .success;
}
