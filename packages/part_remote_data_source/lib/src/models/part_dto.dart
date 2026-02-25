import 'package:json_annotation/json_annotation.dart';

part 'part_dto.g.dart';

@JsonSerializable()
class PartDto {
  PartDto({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.brand,
    required this.description,
  });

  factory PartDto.fromJson(Map<String, dynamic> json) =>
      _$PartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PartDtoToJson(this);

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
