import 'package:inventory_app/inventory/models/storage_quantity_model.dart';

class PartUiModel {
  PartUiModel({
    required this.partId,
    required this.name,
    required this.detailNumber,
    required this.price,
    required this.isRecycled,
    this.stock = const [],
    this.brand,
    this.description,
  });

  final String partId;
  final String name;
  final String detailNumber;
  final double price;
  final bool isRecycled;
  final String? brand;
  final String? description;
  final List<StorageQuantityModel> stock;

  int get totalQuantity =>
      stock.fold(0, (sum, element) => sum + element.quantity);
}
