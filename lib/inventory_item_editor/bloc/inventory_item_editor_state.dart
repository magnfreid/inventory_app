import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item_editor_state.freezed.dart';

enum InventoryItemEditorStatus { idle, loading, success, error }

@freezed
abstract class InventoryItemEditorState with _$InventoryItemEditorState {
  const factory InventoryItemEditorState({
    @Default(InventoryItemEditorStatus.idle) InventoryItemEditorStatus status,
  }) = _InventoryItemEditorState;
  const InventoryItemEditorState._();

  bool get isLoading => status == .loading;
  bool get isSuccess => status == .success;
}
