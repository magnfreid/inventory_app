part of 'inventory_item_editor_bloc.dart';

sealed class InventoryItemEditorEvent {
  const InventoryItemEditorEvent();
}

final class SaveButtonPressed extends InventoryItemEditorEvent {
  const SaveButtonPressed({required this.productCreateModel});
  final ProductCreateModel productCreateModel;
}
