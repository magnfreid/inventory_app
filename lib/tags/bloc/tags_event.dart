part of 'tags_bloc.dart';

sealed class TagsEvent {
  const TagsEvent();
}

final class _TagsUpdated extends TagsEvent {
  const _TagsUpdated({required this.tags});
  final List<TagUiModel> tags;
}

final class SaveButtonPressed extends TagsEvent {
  const SaveButtonPressed({required this.tag});
  final TagCreate tag;
}
