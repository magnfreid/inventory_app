import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/inventory/models/stock_ui_model.dart';
import 'package:part_repository/part_repository.dart';

import 'package:rxdart/rxdart.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required PartRepository partRepository,
    required StorageRepository storageRepository,
    required StockRepository stockRepository,
    required TagRepository tagRepository,
  }) : _partRepository = partRepository,
       _storageRepository = storageRepository,
       _stockRepository = stockRepository,
       _tagRepository = tagRepository,
       super(const InventoryState()) {
    on<_PartsUpdated>(_onPartsUpdated);
    on<UseStockButtonPressed>(_onUseStockButtonPressed);

    setStreamSubscription();
  }

  final PartRepository _partRepository;
  final StockRepository _stockRepository;
  final StorageRepository _storageRepository;
  final TagRepository _tagRepository;
  late final StreamSubscription<List<PartUiModel>> _streamSubscription;

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
  ) {
    emit(state.copyWith(bottomSheetStatus: .loading));
    try {
      _stockRepository.decreaseStock(
        partId: event.partId,
        storageId: event.storageId,
        amount: 1,
      );
      emit(state.copyWith(bottomSheetStatus: .success));
    } on Exception catch (exception) {
      emit(state.copyWith(bottomSheetStatus: .error));
    }
  }

  void setStreamSubscription() {
    _streamSubscription =
        Rx.combineLatest4<
              List<Stock>,
              List<Part>,
              List<Storage>,
              List<Tag>,
              List<PartUiModel>
            >(
              _stockRepository.watchStock(),
              _partRepository.watchParts(),
              _storageRepository.watchStorages(),
              _tagRepository.watchMainTags(),
              (stocks, parts, storages, tags) {
                final storagesMap = {
                  for (final storage in storages) storage.id: storage,
                };
                final tagsMap = {
                  for (final tag in tags) tag.id: tag,
                };
                final stockByPart = <String, List<Stock>>{};
                for (final stock in stocks) {
                  stockByPart.putIfAbsent(stock.partId, () => []).add(stock);
                }
                final uiItems = <PartUiModel>[];
                for (final part in parts) {
                  final partStock = stockByPart[part.id] ?? const [];
                  final storageQuantities = partStock.map((stock) {
                    final storage = storagesMap[stock.storageId];
                    return StockUiModel(
                      storageId: stock.storageId,
                      storageName: storage?.name ?? 'Unknown',
                      quantity: stock.quantity,
                    );
                  }).toList();
                  final mainTag = part.mainTagId != null
                      ? tagsMap[part.mainTagId!]
                      : null;
                  uiItems.add(
                    PartUiModel(
                      partId: part.id,
                      name: part.name,
                      detailNumber: part.detailNumber,
                      price: part.price,
                      isRecycled: part.isRecycled,
                      mainTag: mainTag,
                      description: part.description,
                      stock: storageQuantities,
                    ),
                  );
                }
                return uiItems;
              },
            )
            .listen(
              (parts) => add(_PartsUpdated(parts: parts)),
            );
  }
}
