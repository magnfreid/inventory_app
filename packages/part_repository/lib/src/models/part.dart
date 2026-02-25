import 'package:json_annotation/json_annotation.dart';
import 'package:part_repository/src/models/part_create_model.dart';

part 'part.g.dart';

@JsonSerializable()
class Part {
  Part({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.brand,
    required this.description,
  });

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  factory Part.fromCreateModel(String id, PartCreateModel createModel) => Part(
    id: id,
    name: createModel.name,
    detailNumber: createModel.detailNumber,
    isRecycled: createModel.isRecycled,
    price: createModel.price,
    brand: createModel.brand,
    description: createModel.description,
  );

  Map<String, dynamic> toJson() => _$PartToJson(this);

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
