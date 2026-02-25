import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';

part 'inventory_state.freezed.dart';

enum InventoryStateStatus { loading, loaded }

@freezed
abstract class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default(InventoryStateStatus.loading) InventoryStateStatus status,
    @Default([]) List<PartUiModel> parts,
  }) = _InventoryState;
  const InventoryState._();

  bool get isLoading => status == .loading;
}
