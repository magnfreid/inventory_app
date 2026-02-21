import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/inventory/models/inventory_item_ui_model.dart';

part 'inventory_state.freezed.dart';

enum InventoryStateStatus { loading, loaded }

enum InventoyStateSaveStatus { idle, loading, success, error }

@freezed
abstract class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default(InventoryStateStatus.loading) InventoryStateStatus status,
    @Default([]) List<InventoryItemUiModel> items,
    @Default(InventoyStateSaveStatus.idle) InventoyStateSaveStatus saveStatus,
  }) = _InventoryState;
  const InventoryState._();

  bool get isLoading => status == .loading;
  bool get isSaving => saveStatus == .loading;
}
