import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:part_repository/part_repository.dart';

class PartPresentation {
  PartPresentation({
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
    this.imgPath,
  });

  final String partId;
  final String name;
  final String detailNumber;
  final double price;
  final bool isRecycled;
  final TagPresentation? categoryTag;
  final TagPresentation? brandTag;
  final List<TagPresentation> generalTags;
  final String? description;
  final List<StockPresentation> stock;
  final String? imgPath;

  Part toDomainModel() => Part(
    id: partId,
    name: name,
    detailNumber: detailNumber,
    price: price,
    isRecycled: isRecycled,
    brandTagId: brandTag?.id,
    categoryTagId: categoryTag?.id,
    generalTagIds: generalTags.map((tag) => tag.id).toList(),
    description: description,
    imgPath: imgPath,
  );

  int get totalQuantity =>
      stock.fold(0, (sum, element) => sum + element.quantity);
}
