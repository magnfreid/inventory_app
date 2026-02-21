import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item_details_state.freezed.dart';

enum InventoryItemDetailsStatus { idle, loading, success, error }

@freezed
abstract class InventoryItemDetailsState with _$InventoryItemDetailsState {
  const factory InventoryItemDetailsState({
    @Default(InventoryItemDetailsStatus.idle) InventoryItemDetailsStatus status,
  }) = _InventoryItemDetailsState;
  const InventoryItemDetailsState._();
}
