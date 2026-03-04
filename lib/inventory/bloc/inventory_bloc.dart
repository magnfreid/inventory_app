import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';

import 'package:stock_repository/stock_repository.dart';

part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required WatchPartPresentations watchPartPresentations,
    required StockRepository stockRepository,
  }) : _stockRepository = stockRepository,
       super(const InventoryState()) {
    on<_PartsUpdated>(_onPartsUpdated);
    on<UseStockButtonPressed>(_onUseStockButtonPressed);

    _streamSubscription = watchPartPresentations().listen(
      (parts) => add(_PartsUpdated(parts: parts)),
    );
  }

  final StockRepository _stockRepository;
  late final StreamSubscription<List<PartPresentation>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onPartsUpdated(
    _PartsUpdated event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(parts: event.parts));
  }

  FutureOr<void> _onUseStockButtonPressed(
    UseStockButtonPressed event,
    Emitter<InventoryState> emit,
  ) async {
    emit(state.copyWith(bottomSheetStatus: .loading));
    try {
      await _stockRepository.decreaseStock(
        partId: event.partId,
        storageId: event.storageId,
        amount: 1,
      );
      emit(state.copyWith(bottomSheetStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(bottomSheetStatus: .error));
    }
  }
}
