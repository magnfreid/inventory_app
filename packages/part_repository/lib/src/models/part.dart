import 'package:part_remote/part_remote.dart';
import 'package:part_repository/src/models/part_create.dart';

class Part {
  Part({
    required this.generalTagIds,
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.categoryTagId,
    required this.description,
    this.brandTagId,
  });

  factory Part.fromCreateModel(String id, PartCreate createModel) => Part(
    id: id,
    name: createModel.name,
    detailNumber: createModel.detailNumber,
    isRecycled: createModel.isRecycled,
    price: createModel.price,
    categoryTagId: createModel.categoryTagId,
    brandTagId: createModel.brandTagId,
    generalTagIds: createModel.generalTagIds,
    description: createModel.description,
  );

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

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? categoryTagId;
  final String? brandTagId;
  final List<String>? generalTagIds;
  final String? description;
}
