import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_state.dart';
import 'package:storage_repository/storage_repository.dart';

part 'storages_editor_event.dart';

class StoragesEditorBloc
    extends Bloc<StoragesEditorEvent, StoragesEditorState> {
  StoragesEditorBloc({required StorageRepository storageRepository})
    : _storageRepository = storageRepository,
      super(const StoragesEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed, transformer: droppable());
    on<_OnStreamError>(_onStreamError);
  }

  final StorageRepository _storageRepository;

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<StoragesEditorState> emit,
  ) async {
    final storage = event.storage;
    emit(state.copyWith(status: .loading, error: null));
    try {
      if (storage.id == null) {
        await _storageRepository.addStorage(
          storage: storage,
        );
      } else {
        await _storageRepository.editStorage(storage: storage);
      }
      emit(state.copyWith(status: .success));
    } on Exception catch (e) {
      emit(state.copyWith(status: .idle, error: e));
    }
  }

  FutureOr<void> _onStreamError(
    _OnStreamError event,
    Emitter<StoragesEditorState> emit,
  ) {
    emit(state.copyWith(error: event.error));
  }
}
