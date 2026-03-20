import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core_remote/core_remote.dart';
import 'package:inventory_app/shared/utilities/bloc_transformers.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:storage_repository/storage_repository.dart';

part 'storages_event.dart';

class StoragesBloc extends Bloc<StoragesEvent, StoragesState> {
  StoragesBloc({required StorageRepository storageRepository})
    : _storageRepository = storageRepository,
      super(const StoragesState()) {
    on<_StoragesUpdated>(
      _onStoragesUpdated,
      transformer: throttle(const Duration(milliseconds: 500)),
    );
    on<_OnStreamError>(_onStreamError);

    _streamSubscription = _storageRepository.watchStorages().listen(
      (data) => add(_StoragesUpdated(storages: data)),
      onError: _handleStreamError,
    );
  }

  final StorageRepository _storageRepository;
  late final StreamSubscription<List<Storage>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onStoragesUpdated(
    _StoragesUpdated event,
    Emitter<StoragesState> emit,
  ) {
    emit(state.copyWith(status: .loaded, storages: event.storages));
  }

  FutureOr<void> _onStreamError(
    _OnStreamError event,
    Emitter<StoragesState> emit,
  ) {
    emit(state.copyWith(error: event.error));
  }

  void _handleStreamError(dynamic e) {
    final error = (e is RemoteException) ? e : const UnknownRemoteException();
    add(_OnStreamError(error: error));
  }
}
