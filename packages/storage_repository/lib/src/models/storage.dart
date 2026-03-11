import 'package:storage_remote/storage_remote.dart';

/// Domain model representing a storage location.
class Storage {
  /// Creates a [Storage] instance.
  Storage({
    required this.id,
    required this.name,
    this.description,
  });

  /// Creates a [Storage] from a [StorageDto].
  ///
  /// If the DTO's `id` is `null`, an empty string is used.
  factory Storage.fromDto(StorageDto dto) =>
      Storage(id: dto.id ?? '', name: dto.name, description: dto.description);

  /// Converts this [Storage] to a [StorageDto].
  StorageDto toDto() =>
      StorageDto(id: id, name: name, description: description);

  /// Unique identifier of the storage.
  final String? id;

  /// Display name of the storage location.
  final String name;

  /// Optional description providing additional details about the storage.
  String? description;

  /// Returns a readable string representation of this [Storage].
  @override
  String toString() =>
      'Storage(id: $id, name: $name, description: $description)';
}
