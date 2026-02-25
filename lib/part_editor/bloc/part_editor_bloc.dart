import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_editor_event.dart';

class PartEditorBloc extends Bloc<PartEditorEvent, PartEditorState> {
  PartEditorBloc({
    required StockRepository stockRepository,
    required StorageRepository storageRepository,
    required PartRepository partRepository,
  }) : _stockRepository = stockRepository,
       _storageRepository = storageRepository,
       _partRepository = partRepository,
       super(const PartEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  final StockRepository _stockRepository;
  final StorageRepository _storageRepository;
  final PartRepository _partRepository;

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<PartEditorState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _partRepository.addPart(event.partCreateModel);
      emit(state.copyWith(status: .success));
    } on Exception catch (_) {
      emit(state.copyWith(status: .error));
    }
  }
}
