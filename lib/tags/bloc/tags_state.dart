import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tag_repository/tag_repository.dart';

part 'tags_state.freezed.dart';

enum TagsStateStatus { loading, loaded }

enum TagsStateBottomSheetStatus { idle, loading, success }

@freezed
abstract class TagsState with _$TagsState {
  const factory TagsState({
    @Default(TagsStateStatus.loading) TagsStateStatus status,
    @Default(TagsStateBottomSheetStatus.idle)
    TagsStateBottomSheetStatus bottomSheetStatus,
    @Default([]) List<Tag> tags,
  }) = _TagsState;
  const TagsState._();
}
