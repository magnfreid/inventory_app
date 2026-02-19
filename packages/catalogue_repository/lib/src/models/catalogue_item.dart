import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalogue_item.g.dart';

@JsonSerializable()
class CatalogueItem {
  CatalogueItem({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    this.brand,
    this.description,
  });

  factory CatalogueItem.fromJson(Map<String, dynamic> json) =>
      _$CatalogueItemFromJson(json);

  factory CatalogueItem.fromCreateItem({
    required String id,
    required CatalogueItemCreate item,
  }) => CatalogueItem(
    id: id,
    name: item.name,
    detailNumber: item.detailNumber,
    isRecycled: item.isRecycled,
    price: item.price,
    brand: item.brand,
    description: item.description,
  );

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;

  Map<String, dynamic> toJson() => _$CatalogueItemToJson(this);
}
