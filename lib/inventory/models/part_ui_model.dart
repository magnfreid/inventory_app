import 'package:inventory_app/inventory/models/stock_ui_model.dart';
import 'package:inventory_app/tags/models/tag_ui_model.dart';

class PartUiModel {
  PartUiModel({
    required this.partId,
    required this.name,
    required this.detailNumber,
    required this.price,
    required this.isRecycled,
    this.stock = const [],
    this.categoryTag,
    this.brandTag,
    this.generalTags = const [],
    this.description,
  });

  final String partId;
  final String name;
  final String detailNumber;
  final double price;
  final bool isRecycled;
  final TagUiModel? categoryTag;
  final TagUiModel? brandTag;
  final List<TagUiModel> generalTags;
  final String? description;
  final List<StockUiModel> stock;

  int get totalQuantity =>
      stock.fold(0, (sum, element) => sum + element.quantity);
}
