import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_event.dart';

class PartDetailsBloc extends Bloc<PartDetailsEvent, PartDetailsState> {
  PartDetailsBloc({
    required StockRepository stockRepository,
    required StorageRepository storageRepository,
  }) : _stockRepository = stockRepository,
       super(const PartDetailsState()) {
    on<_StoragesUpdated>(_onStoragesUpdated);
    on<ShowAddViewButtonPressed>(_onShowAddViewButtonPressed);
    on<SaveButtonPressed>(_onSaveButtonPressed);

    _streamSubscription = storageRepository.watchStorages().listen(
      (data) => add(_StoragesUpdated(storages: data)),
    );
  }

  final StockRepository _stockRepository;
  late final StreamSubscription<List<Storage>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onStoragesUpdated(
    _StoragesUpdated event,
    Emitter<PartDetailsState> emit,
  ) {
    emit(state.copyWith(status: .success, storages: event.storages));
  }

  FutureOr<void> _onShowAddViewButtonPressed(
    ShowAddViewButtonPressed event,
    Emitter<PartDetailsState> emit,
  ) {
    final current = state.showAddView;
    emit(state.copyWith(showAddView: !current));
  }

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
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
}
