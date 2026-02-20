import 'package:json_annotation/json_annotation.dart';

part 'product_create_model.g.dart';

@JsonSerializable()
class ProductCreateModel {
  ProductCreateModel({
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.brand,
    required this.description,
  });

  factory ProductCreateModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCreateModelToJson(this);

  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
