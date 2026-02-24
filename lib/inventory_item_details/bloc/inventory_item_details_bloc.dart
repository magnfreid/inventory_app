import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory_item_details/bloc/inventory_item_details_state.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';

part 'inventory_item_details_event.dart';

class InventoryItemDetailsBloc
    extends Bloc<InventoryItemDetailsEvent, InventoryItemDetailsState> {
  InventoryItemDetailsBloc({
    required InventoryRepository inventoryRepository,
    required LocationRepository locationRepository,
  }) : _inventoryRepository = inventoryRepository,
       _locationRepository = locationRepository,
       super(const InventoryItemDetailsState()) {
    on<_LocationsUpdated>(_onLocationsUpdated);
    on<ShowAddViewButtonPressed>(_onShowAddViewButtonPressed);
    on<SaveButtonPressed>(_onSaveButtonPressed);

    _streamSubscription = locationRepository.watchLocations().listen(
      (data) => add(_LocationsUpdated(locations: data)),
    );
  }

  final InventoryRepository _inventoryRepository;
  final LocationRepository _locationRepository;
  late final StreamSubscription<List<Location>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onLocationsUpdated(
    _LocationsUpdated event,
    Emitter<InventoryItemDetailsState> emit,
  ) {
    emit(state.copyWith(status: .success, locations: event.locations));
  }

  FutureOr<void> _onShowAddViewButtonPressed(
    ShowAddViewButtonPressed event,
    Emitter<InventoryItemDetailsState> emit,
  ) {
    final current = state.showAddView;
    emit(state.copyWith(showAddView: !current));
  }

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<InventoryItemDetailsState> emit,
  ) {
    emit(state.copyWith(saveStatus: .loading));
    try {
      _inventoryRepository.increaseStock(
        productId: event.productId,
        locationId: event.locationId,
        amount: event.amount,
      );
      emit(state.copyWith(saveStatus: .success));
    } on Exception catch (exception) {
      emit(state.copyWith(saveStatus: .error));
    }
  }
}
