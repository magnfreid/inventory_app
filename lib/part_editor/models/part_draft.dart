import 'package:part_repository/part_repository.dart';

class PartDraft {
  PartDraft({
    required this.name,
    required this.isRecycled,
    required this.price,
    this.detailNumber = '',
    this.id,
    this.categoryTagId,
    this.brandTagId,
    this.generalTagIds = const [],
    this.description,
  });

  final String? id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? categoryTagId;
  final String? brandTagId;
  final List<String> generalTagIds;
  final String? description;

  PartCreate toCreateModel() => PartCreate(
    name: name,
    detailNumber: detailNumber,
    isRecycled: isRecycled,
    price: price,
    categoryTagId: categoryTagId,
    brandTagId: brandTagId,
    generalTagIds: generalTagIds,
    description: description,
  );

  Part toPart(String id) => Part(
    id: id,
    name: name,
    detailNumber: detailNumber,
    isRecycled: isRecycled,
    price: price,
    brandTagId: brandTagId,
    categoryTagId: categoryTagId,
    generalTagIds: generalTagIds,
    description: description,
  );
}
