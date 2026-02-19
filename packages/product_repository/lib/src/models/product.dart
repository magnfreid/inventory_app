import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  Product({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.brand,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
