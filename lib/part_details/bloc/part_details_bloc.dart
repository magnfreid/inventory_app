import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core_remote/core_remote.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/shared/utilities/bloc_transformers.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_event.dart';

class PartDetailsBloc extends Bloc<PartDetailsEvent, PartDetailsState> {
  PartDetailsBloc({
    required StockRepository stockRepository,
    required StorageRepository storageRepository,
    required PartRepository partRepository,
    required PartPresentation initialPart,
    required WatchSinglePartPresentation watchSinglePartPresentation,
  }) : _stockRepository = stockRepository,
       _partRepository = partRepository,
       super(PartDetailsState(part: initialPart)) {
    on<_StoragesUpdated>(_onStoragesUpdated);
    on<_PartUpdated>(
      _onPartUpdated,
      transformer: debounceRestartable(const Duration(milliseconds: 500)),
    );
    on<ButtonSegmentPressed>(_onButtonSegmentPressed);
    on<UseButtonPressed>(_onUseButtonPressed, transformer: droppable());
    on<AddToStockButtonPressed>(
      _onAddToStockButtonPressed,
      transformer: droppable(),
    );
    on<ConfirmDeleteButtonPressed>(
      _onConfirmDeleteButtonPressed,
      transformer: droppable(),
    );
    on<_OnStreamError>(_onStreamError);

    _storagesStreamSubscription = storageRepository.watchStorages().listen(
      (data) => add(_StoragesUpdated(storages: data)),
      onError: _handleStreamError,
    );

    _partStreamSubscription =
        watchSinglePartPresentation(
          initialPart.partId,
        ).listen(
          (part) {
            if (part != null) add(_PartUpdated(part: part));
          },
          onError: _handleStreamError,
        );
  }

  final StockRepository _stockRepository;
  final PartRepository _partRepository;

  late final StreamSubscription<List<Storage>> _storagesStreamSubscription;
  late final StreamSubscription<PartPresentation?> _partStreamSubscription;

  @override
  Future<void> close() async {
    await _storagesStreamSubscription.cancel();
    await _partStreamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onStoragesUpdated(
    _StoragesUpdated event,
    Emitter<PartDetailsState> emit,
  ) {
    emit(state.copyWith(storages: event.storages));
  }

  FutureOr<void> _onPartUpdated(
    _PartUpdated event,
    Emitter<PartDetailsState> emit,
  ) {
    emit(state.copyWith(part: event.part));
  }

  FutureOr<void> _onButtonSegmentPressed(
    ButtonSegmentPressed event,
    Emitter<PartDetailsState> emit,
  ) {
    emit(state.copyWith(content: event.content));
  }

  FutureOr<void> _onUseButtonPressed(
    UseButtonPressed event,
    Emitter<PartDetailsState> emit,
  ) async {
    emit(state.copyWith(saveStatus: .loading, error: null));
    try {
      await _stockRepository.useStock(
        partId: event.partId,
        storageId: event.storageId,
        userId: event.userId,
        note: event.note,
      );
      emit(state.copyWith(saveStatus: .done));
    } on Exception catch (e) {
      emit(state.copyWith(saveStatus: .done, error: e));
    }
  }

  FutureOr<void> _onAddToStockButtonPressed(
    AddToStockButtonPressed event,
    Emitter<PartDetailsState> emit,
  ) async {
    emit(state.copyWith(saveStatus: .loading, error: null));
    try {
      await _stockRepository.restockStock(
        partId: event.partId,
        storageId: event.storageId,
        amount: event.amount,
        userId: event.userId,
        note: event.note,
      );
      emit(state.copyWith(saveStatus: .done));
    } on Exception catch (e) {
      emit(state.copyWith(saveStatus: .done, error: e));
    }
  }

  FutureOr<void> _onConfirmDeleteButtonPressed(
    ConfirmDeleteButtonPressed event,
    Emitter<PartDetailsState> emit,
  ) async {
    emit(state.copyWith(deleteStatus: .loading, error: null));
    try {
      await _partRepository.deletePart(event.partId);
      emit(state.copyWith(deleteStatus: .done));
    } on Exception catch (e) {
      emit(state.copyWith(deleteStatus: .done, error: e));
    }
  }

  FutureOr<void> _onStreamError(
    _OnStreamError event,
    Emitter<PartDetailsState> emit,
  ) {
    emit(state.copyWith(error: event.error));
  }

  void _handleStreamError(dynamic e) {
    final error = (e is RemoteException) ? e : const UnknownRemoteException();
    add(_OnStreamError(error: error));
  }
}
