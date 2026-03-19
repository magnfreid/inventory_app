part of 'storages_editor_bloc.dart';

sealed class StoragesEditorEvent {
  const StoragesEditorEvent();
}

class SaveButtonPressed extends StoragesEditorEvent {
  const SaveButtonPressed({required this.storage});
  final Storage storage;
}

class _OnStreamError extends StoragesEditorEvent {
  const _OnStreamError({required this.error});
  final Exception error;
}
