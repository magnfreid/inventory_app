import 'package:part_remote/part_remote.dart';

class Part {
  Part({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.price,
    required this.isRecycled,
    required this.brandTagId,
    required this.categoryTagId,
    required this.generalTagIds,
    required this.description,
  });

  factory Part.fromDto(PartDto dto) => Part(
    id: dto.id,
    name: dto.name,
    detailNumber: dto.detailNumber,
    isRecycled: dto.isRecycled,
    price: dto.price,
    categoryTagId: dto.categoryTagId,
    brandTagId: dto.brandTagId,
    generalTagIds: dto.generalTagIds,
    description: dto.description,
  );

  PartDto toDto() => PartDto(
    id: id,
    name: name,
    detailNumber: detailNumber,
    isRecycled: isRecycled,
    price: price,
    categoryTagId: categoryTagId,
    description: description,
    brandTagId: brandTagId,
    generalTagIds: generalTagIds,
  );

  final String? id;
  final String name;
  final String detailNumber;
  final double price;
  final bool isRecycled;
  final String? brandTagId;
  final String? categoryTagId;
  final List<String> generalTagIds;
  final String? description;
}
