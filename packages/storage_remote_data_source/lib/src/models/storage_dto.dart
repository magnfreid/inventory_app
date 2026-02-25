import 'package:json_annotation/json_annotation.dart';

part 'storage_dto.g.dart';

@JsonSerializable()
class StorageDto {
  StorageDto({required this.id, required this.name, this.description});

  factory StorageDto.fromJson(Map<String, dynamic> json) =>
      _$StorageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StorageDtoToJson(this);

  final String id;
  final String name;
  String? description;
}
