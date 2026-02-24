import 'package:inventory_app/inventory/models/location_quantity_ui_model.dart';

class InventoryItemUiModel {
  InventoryItemUiModel({
    required this.name,
    required this.detailNumber,
    required this.price,
    this.stock = const [],
    this.brand,
    this.description,
  });

  final String name;
  final String detailNumber;
  final double price;
  final String? brand;
  final String? description;
  final List<LocationQuantityUiModel> stock;

  int get totalQuantity =>
      stock.fold(0, (sum, element) => sum + element.quantity);
}
