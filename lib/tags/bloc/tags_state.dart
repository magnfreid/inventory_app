import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/tags/models/tag_ui_model.dart';

part 'tags_state.freezed.dart';

enum TagsStateStatus { loading, loaded }

enum TagsStateBottomSheetStatus { idle, loading, success }

@freezed
abstract class TagsState with _$TagsState {
  const factory TagsState({
    @Default(TagsStateStatus.loading) TagsStateStatus status,
    @Default(TagsStateBottomSheetStatus.idle)
    TagsStateBottomSheetStatus bottomSheetStatus,
    @Default([]) List<TagUiModel> brandTags,
    @Default([]) List<TagUiModel> categoryTags,
    @Default([]) List<TagUiModel> generalTags,
  }) = _TagsState;
  const TagsState._();
}
