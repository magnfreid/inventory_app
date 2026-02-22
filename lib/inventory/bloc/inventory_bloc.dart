import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_item_ui_model.dart';
import 'package:inventory_app/inventory/models/storage_quantity_ui_model.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required LocationRepository locationRepository,
    required InventoryRepository inventoryRepository,
    required ProductRepository productRepository,
  }) : _locationRepository = locationRepository,
       _inventoryRepository = inventoryRepository,
       _productRepository = productRepository,
       super(const InventoryState()) {
    on<_InventoryListUpdated>(_onInventoryListUpdated);

    setStreamSubscription();
  }

  final LocationRepository _locationRepository;
  final InventoryRepository _inventoryRepository;
  final ProductRepository _productRepository;
  late final StreamSubscription<List<InventoryItemUiModel>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onInventoryListUpdated(
    _InventoryListUpdated event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(items: event.items));
  }

  void setStreamSubscription() {
    _streamSubscription = Rx.combineLatest3(
      _inventoryRepository.watchInventoryItems(),
      _productRepository.watchProducts(),
      _locationRepository.watchLocations(),
      (
        inventoryItems,
        products,
        locations,
      ) {
        final locationMap = {
          for (final location in locations) location.id: location,
        };

        final inventoryByProduct = <String, List<InventoryItem>>{};

        for (final inventory in inventoryItems) {
          inventoryByProduct
              .putIfAbsent(inventory.productId, () => [])
              .add(inventory);
        }

        final uiItems = <InventoryItemUiModel>[];

        for (final product in products) {
          final productInventory = inventoryByProduct[product.id] ?? const [];
          final storageQuantities = productInventory.map((inventory) {
            final location = locationMap[inventory.storageId];
            return StorageQuantityUiModel(
              storageName: location?.name ?? 'Unknown',
              quantity: inventory.quantity,
            );
          }).toList();
          uiItems.add(
            InventoryItemUiModel(
              name: product.name,
              detailNumber: product.detailNumber,
              price: product.price,
              brand: product.brand,
              description: product.description,
              storageQuantities: storageQuantities,
            ),
          );
        }
        return uiItems;
      },
    ).listen((items) => add(_InventoryListUpdated(items: items)));
  }
}
