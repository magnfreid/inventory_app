import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';

part 'tags_state.freezed.dart';

enum TagsStateStatus { loading, loaded }

enum TagsStateBottomSheetStatus { idle, loading, done }

@freezed
abstract class TagsState with _$TagsState {
  const factory TagsState({
    @Default(TagsStateStatus.loading) TagsStateStatus status,
    @Default(TagsStateBottomSheetStatus.idle)
    TagsStateBottomSheetStatus bottomSheetStatus,
    @Default([]) List<TagPresentation> brandTags,
    @Default([]) List<TagPresentation> categoryTags,
    @Default([]) List<TagPresentation> generalTags,
    Exception? error,
  }) = _TagsState;
  const TagsState._();
}
