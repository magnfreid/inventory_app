part of 'storages_editor_bloc.dart';

sealed class StorageEditorEvent {
  const StorageEditorEvent();
}

final class SaveButtonPressed extends StorageEditorEvent {
  const SaveButtonPressed({required this.storageCreateModel});
  final StorageCreateModel storageCreateModel;
}
