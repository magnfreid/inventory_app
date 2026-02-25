import 'package:storage_remote_data_source/storage_remote_data_source.dart';
import 'package:storage_repository/src/models/storage_create_model.dart';

class Storage {
  Storage({required this.id, required this.name, this.description});

  factory Storage.fromDto(StorageDto dto) =>
      Storage(id: dto.id, name: dto.name, description: dto.description);

  factory Storage.fromCreateModel({
    required String id,
    required StorageCreateModel createModel,
  }) => Storage(
    id: id,
    name: createModel.name,
    description: createModel.description,
  );

  final String id;
  final String name;
  String? description;
}
