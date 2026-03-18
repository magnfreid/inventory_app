import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
    required String partId,
    required WatchSinglePartPresentation watchSinglePartPresentation,
  }) : _stockRepository = stockRepository,
       _partRepository = partRepository,
       super(const PartDetailsState()) {
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

    _storagesStreamSubscription = storageRepository.watchStorages().listen(
      (data) => add(_StoragesUpdated(storages: data)),
    );

    _partStreamSubscription = watchSinglePartPresentation(
      partId,
    ).listen((part) => add(_PartUpdated(part: part)));
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
    emit(state.copyWith(saveStatus: .loading));
    try {
      await _stockRepository.decreaseStock(
        partId: event.partId,
        storageId: event.storageId,
        amount: 1,
      );
      emit(state.copyWith(saveStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(saveStatus: .error));
    }
  }

  FutureOr<void> _onAddToStockButtonPressed(
    AddToStockButtonPressed event,
    Emitter<PartDetailsState> emit,
  ) async {
    emit(state.copyWith(saveStatus: .loading));
    try {
      await _stockRepository.increaseStock(
        partId: event.partId,
        storageId: event.storageId,
        amount: event.amount,
      );
      emit(state.copyWith(saveStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(saveStatus: .error));
    }
  }

  FutureOr<void> _onConfirmDeleteButtonPressed(
    ConfirmDeleteButtonPressed event,
    Emitter<PartDetailsState> emit,
  ) async {
    emit(state.copyWith(deleteStatus: .loading));
    try {
      await _partRepository.deletePart(event.partId);
      emit(state.copyWith(deleteStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(deleteStatus: .error));
    }
  }
}
