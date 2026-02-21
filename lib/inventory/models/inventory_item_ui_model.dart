import 'package:inventory_app/inventory/models/storage_quantity_ui_model.dart';

class InventoryItemUiModel {
  InventoryItemUiModel({
    required this.name,
    required this.detailNumber,
    required this.price,
    this.storageQuantities = const [],
    this.brand,
    this.description,
  });

  final String name;
  final String detailNumber;
  final double price;
  final String? brand;
  final String? description;
  final List<StorageQuantityUiModel> storageQuantities;

  int get totalQuantity =>
      storageQuantities.fold(0, (sum, element) => sum + element.quantity);
}
