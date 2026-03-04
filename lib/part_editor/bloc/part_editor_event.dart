part of 'part_editor_bloc.dart';

sealed class PartEditorEvent {
  const PartEditorEvent();
}

final class SaveButtonPressed extends PartEditorEvent {
  const SaveButtonPressed({required this.part});
  final Part part;
}

final class _TagsUpdated extends PartEditorEvent {
  const _TagsUpdated({required this.tags});
  final List<TagPresentation> tags;
}
