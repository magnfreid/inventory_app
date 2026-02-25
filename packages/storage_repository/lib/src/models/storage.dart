import 'package:json_annotation/json_annotation.dart';
import 'package:storage_repository/src/models/storage_create_model.dart';

part 'storage.g.dart';

@JsonSerializable()
class Storage {
  Storage({required this.id, required this.name, this.description});

  factory Storage.fromJson(Map<String, dynamic> json) =>
      _$StorageFromJson(json);

  factory Storage.fromCreateModel({
    required String id,
    required StorageCreateModel createModel,
  }) => Storage(
    id: id,
    name: createModel.name,
    description: createModel.description,
  );

  Map<String, dynamic> toJson() => _$StorageToJson(this);

  final String id;
  final String name;
  String? description;
}
