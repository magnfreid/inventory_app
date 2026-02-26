part of 'part_editor_bloc.dart';

sealed class PartEditorEvent {
  const PartEditorEvent();
}

final class SaveButtonPressed extends PartEditorEvent {
  const SaveButtonPressed({required this.partCreateModel});
  final PartCreate partCreateModel;
}
