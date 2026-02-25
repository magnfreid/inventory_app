import 'package:json_annotation/json_annotation.dart';

part 'part_create_model.g.dart';

@JsonSerializable()
class PartCreateModel {
  PartCreateModel({
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.brand,
    required this.description,
  });

  factory PartCreateModel.fromJson(Map<String, dynamic> json) =>
      _$PartCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartCreateModelToJson(this);

  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
