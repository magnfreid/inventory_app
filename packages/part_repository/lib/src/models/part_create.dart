import 'package:json_annotation/json_annotation.dart';
import 'package:part_remote/part_remote.dart';

part 'part_create.g.dart';

@JsonSerializable()
class PartCreate {
  PartCreate({
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.mainTagId,
    required this.description,
  });

  factory PartCreate.fromJson(Map<String, dynamic> json) =>
      _$PartCreateFromJson(json);

  PartCreateDto toCreateDto() => PartCreateDto(
    name: name,
    detailNumber: detailNumber,
    isRecycled: isRecycled,
    price: price,
    mainTagId: mainTagId,
    description: description,
  );

  Map<String, dynamic> toJson() => _$PartCreateToJson(this);

  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? mainTagId;
  final String? description;
}
