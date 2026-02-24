import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_repository/location_repository.dart';

part 'inventory_item_details_state.freezed.dart';

enum InventoryItemDetailsStatus { loading, loaded, success }

enum InventoryItemDetailsSaveStatus { idle, loading, success, error }

@freezed
abstract class InventoryItemDetailsState with _$InventoryItemDetailsState {
  const factory InventoryItemDetailsState({
    @Default(InventoryItemDetailsStatus.loading)
    InventoryItemDetailsStatus status,
    @Default(InventoryItemDetailsSaveStatus.idle)
    InventoryItemDetailsSaveStatus saveStatus,
    @Default([]) List<Location> locations,
    @Default(false) bool showAddView,
  }) = _InventoryItemDetailsState;
  const InventoryItemDetailsState._();
}
