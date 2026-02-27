import 'package:inventory_app/inventory/models/storage_quantity_model.dart';
import 'package:tag_repository/tag_repository.dart';

class PartUiModel {
  PartUiModel({
    required this.partId,
    required this.name,
    required this.detailNumber,
    required this.price,
    required this.isRecycled,
    this.stock = const [],
    this.mainTag,
    this.description,
  });

  final String partId;
  final String name;
  final String detailNumber;
  final double price;
  final bool isRecycled;
  final Tag? mainTag;
  final String? description;
  final List<StorageQuantityModel> stock;

  int get totalQuantity =>
      stock.fold(0, (sum, element) => sum + element.quantity);
}
