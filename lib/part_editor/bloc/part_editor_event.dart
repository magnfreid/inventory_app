part of 'part_editor_bloc.dart';

sealed class PartEditorEvent {
  const PartEditorEvent();
}

final class SaveButtonPressed extends PartEditorEvent {
  const SaveButtonPressed({required this.partCreateModel});
  final PartCreate partCreateModel;
}

final class UseButtonPressed extends PartEditorEvent {
  const UseButtonPressed({required this.partId, required this.storageId});
  final String partId;
  final String storageId;
}
