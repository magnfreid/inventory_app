import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/watch_single_part_presentation/watch_single_part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_event.dart';

class PartDetailsBloc extends Bloc<PartDetailsEvent, PartDetailsState> {
  PartDetailsBloc({
    // required StockRepository stockRepository,
    // required StorageRepository storageRepository,
    required String partId,
    required WatchSinglePartPresentation watchSinglePartPresentation,
  }) : // _stockRepository = stockRepository,
       super(const PartDetailsState()) {
    // on<_StoragesUpdated>(_onStoragesUpdated);
    // on<ShowAddViewButtonPressed>(_onShowAddViewButtonPressed);
    // on<SaveButtonPressed>(_onSaveButtonPressed);
    on<_PartUpdated>(_onPartUpdated);

    // _streamSubscription = storageRepository.watchStorages().listen(
    //   (data) => add(_StoragesUpdated(storages: data)),
    // );

    _partStreamSubscription = watchSinglePartPresentation(
      partId,
    ).listen((part) => add(_PartUpdated(part: part)));
  }

  // final StockRepository _stockRepository;

  // late final StreamSubscription<List<Storage>> _streamSubscription;
  late final StreamSubscription<PartPresentation?> _partStreamSubscription;

  @override
  Future<void> close() async {
    // await _streamSubscription.cancel();
    await _partStreamSubscription.cancel();
    return super.close();
  }

  // FutureOr<void> _onStoragesUpdated(
  //   _StoragesUpdated event,
  //   Emitter<PartDetailsState> emit,
  // ) {
  //   emit(state.copyWith(status: .success, storages: event.storages));
  // }

  // FutureOr<void> _onShowAddViewButtonPressed(
  //   ShowAddViewButtonPressed event,
  //   Emitter<PartDetailsState> emit,
  // ) {
  //   final current = state.showAddView;
  //   emit(state.copyWith(showAddView: !current));
  // }

  // FutureOr<void> _onSaveButtonPressed(
  //   SaveButtonPressed event,
  //   Emitter<PartDetailsState> emit,
  // ) async {
  //   emit(state.copyWith(saveStatus: .loading));
  //   try {
  //     await _stockRepository.increaseStock(
  //       partId: event.partId,
  //       storageId: event.storageId,
  //       amount: event.amount,
  //     );
  //     emit(state.copyWith(saveStatus: .success));
  //   } on Exception catch (_) {
  //     emit(state.copyWith(saveStatus: .error));
  //   }
  // }

  FutureOr<void> _onPartUpdated(
    _PartUpdated event,
    Emitter<PartDetailsState> emit,
  ) {
    emit(state.copyWith(status: .loaded, part: event.part));
  }
}
