import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';

part 'inventory_state.freezed.dart';

enum InventoryStateStatus { loading, loaded }

enum InventoryStateBottomSheetStatus { idle, loading, success, error }

@freezed
abstract class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default(InventoryStateStatus.loading) InventoryStateStatus status,
    @Default(InventoryStateBottomSheetStatus.idle)
    InventoryStateBottomSheetStatus bottomSheetStatus,
    @Default([]) List<PartUiModel> parts,
  }) = _InventoryState;
  const InventoryState._();

  bool get isLoading => status == .loading;
  bool get isLoadingBottomSheet => bottomSheetStatus == .loading;
}
