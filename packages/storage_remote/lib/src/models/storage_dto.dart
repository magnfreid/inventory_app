import 'package:json_annotation/json_annotation.dart';

part 'storage_dto.g.dart';

/// Data Transfer Object representing a storage location.
@JsonSerializable()
class StorageDto {
  /// Creates a [StorageDto] instance.
  StorageDto({
    required this.id,
    required this.name,
    this.description,
  });

  /// Creates a [StorageDto] from a JSON map.
  factory StorageDto.fromJson(Map<String, dynamic> json) =>
      _$StorageDtoFromJson(json);

  /// Converts this [StorageDto] to a JSON map.
  Map<String, dynamic> toJson() => _$StorageDtoToJson(this);

  /// The unique ID of the storage.
  final String id;

  /// The name of the storage location.
  final String name;

  /// Optional description of the storage location.
  String? description;
}
