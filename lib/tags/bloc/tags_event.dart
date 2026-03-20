part of 'tags_bloc.dart';

sealed class TagsEvent {
  const TagsEvent();
}

final class _TagsUpdated extends TagsEvent {
  const _TagsUpdated({required this.tags});
  final List<TagPresentation> tags;
}

final class SaveButtonPressed extends TagsEvent {
  const SaveButtonPressed({required this.tag});
  final Tag tag;
}

final class _OnStreamError extends TagsEvent {
  const _OnStreamError({required this.error});
  final Exception error;
}
