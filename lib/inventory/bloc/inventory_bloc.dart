import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/inventory/models/storage_quantity_model.dart';
import 'package:part_repository/part_repository.dart';

import 'package:rxdart/rxdart.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required StorageRepository storageRepository,
    required StockRepository stockRepository,
    required PartRepository partRepository,
  }) : _storageRepository = storageRepository,
       _stockRepository = stockRepository,
       _partRepository = partRepository,
       super(const InventoryState()) {
    on<_PartsUpdated>(_onPartsUpdated);

    setStreamSubscription();
  }

  final StockRepository _stockRepository;
  final StorageRepository _storageRepository;
  final PartRepository _partRepository;
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

  void setStreamSubscription() {
    _streamSubscription = Rx.combineLatest3(
      _stockRepository.watchStock(),
      _partRepository.watchParts(),
      _storageRepository.watchStorages(),
      (
        stocks,
        parts,
        storages,
      ) {
        final storagesMap = {
          for (final storage in storages) storage.id: storage,
        };

        log('Storages map: $storagesMap');

        final stockByPart = <String, List<Stock>>{};

        for (final stock in stocks) {
          stockByPart.putIfAbsent(stock.partId, () => []).add(stock);
        }

        final uiItems = <PartUiModel>[];

        for (final part in parts) {
          final partStock = stockByPart[part.id] ?? const [];
          final storageQuantities = partStock.map((stock) {
            final storage = storagesMap[stock.storageId];
            return StorageQuantityModel(
              storageId: stock.storageId,
              locationName: storage?.name ?? 'Unknown',
              quantity: stock.quantity,
            );
          }).toList();
          uiItems.add(
            PartUiModel(
              partId: part.id,
              name: part.name,
              detailNumber: part.detailNumber,
              price: part.price,
              brand: part.brand,
              description: part.description,
              stock: storageQuantities,
            ),
          );
        }
        return uiItems;
      },
    ).listen((parts) => add(_PartsUpdated(parts: parts)));
  }
}
