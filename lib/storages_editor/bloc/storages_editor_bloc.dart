import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_state.dart';
import 'package:storage_repository/storage_repository.dart';

part 'storages_editor_event.dart';

class StoragesEditorBloc extends Bloc<StorageEditorEvent, StoragesEditorState> {
  StoragesEditorBloc({required StorageRepository storageRepository})
    : _locationRepository = storageRepository,
      super(const StoragesEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  final StorageRepository _locationRepository;

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<StoragesEditorState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _locationRepository.addStorage(
        storageCreateModel: event.storageCreateModel,
      );
      emit(state.copyWith(status: .success));
    } on Exception catch (_) {}
  }
}
