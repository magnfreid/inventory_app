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
    required this.categoryTagId,
    required this.description,
    required this.brandTagId,
    required this.generalTagIds,
  });

  factory PartDto.fromJson(Map<String, dynamic> json) =>
      _$PartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PartDtoToJson(this);

  PartDto copyWith({
    String? id,
    String? name,
    String? detailNumber,
    bool? isRecycled,
    double? price,
    String? categoryTagId,
    String? brandTagId,
    List<String>? generalTagIds,
    String? description,
  }) {
    return PartDto(
      id: id ?? this.id,
      name: name ?? this.name,
      detailNumber: detailNumber ?? this.detailNumber,
      isRecycled: isRecycled ?? this.isRecycled,
      price: price ?? this.price,
      categoryTagId: categoryTagId ?? this.categoryTagId,
      brandTagId: brandTagId ?? this.brandTagId,
      generalTagIds: generalTagIds ?? this.generalTagIds,
      description: description ?? this.description,
    );
  }

  @JsonKey(includeToJson: false)
  final String? id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? categoryTagId;
  final String? brandTagId;
  final List<String> generalTagIds;
  final String? description;
}
