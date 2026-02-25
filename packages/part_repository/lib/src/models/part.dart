import 'package:part_remote_data_source/part_remote_data_source.dart';
import 'package:part_repository/src/models/part_create_model.dart';

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

  factory Part.fromCreateModel(String id, PartCreateModel createModel) => Part(
    id: id,
    name: createModel.name,
    detailNumber: createModel.detailNumber,
    isRecycled: createModel.isRecycled,
    price: createModel.price,
    brand: createModel.brand,
    description: createModel.description,
  );

  factory Part.fromDto(PartDto dto) => Part(
    id: dto.id,
    name: dto.name,
    detailNumber: dto.detailNumber,
    isRecycled: dto.isRecycled,
    price: dto.price,
    brand: dto.brand,
    description: dto.description,
  );

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? brand;
  final String? description;
}
