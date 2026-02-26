import 'package:json_annotation/json_annotation.dart';

part 'part_create_dto.g.dart';

@JsonSerializable()
class PartCreateDto {
  PartCreateDto({
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.brand,
    required this.description,
  });

  factory PartCreateDto.fromJson(Map<String, dynamic> json) =>
      _$PartCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PartCreateDtoToJson(this);

  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
