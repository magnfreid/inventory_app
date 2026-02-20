import 'package:json_annotation/json_annotation.dart';
import 'package:product_repository/src/models/product_create_model.dart';

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

  factory Product.fromCreateModel(String id, ProductCreateModel createModel) =>
      Product(
        id: id,
        name: createModel.name,
        detailNumber: createModel.detailNumber,
        isRecycled: createModel.isRecycled,
        price: createModel.price,
        brand: createModel.brand,
        description: createModel.description,
      );

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
