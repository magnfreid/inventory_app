import 'package:json_annotation/json_annotation.dart';

part 'storage_create_model.g.dart';

@JsonSerializable()
class StorageCreateModel {
  StorageCreateModel({
    required this.name,
    required this.description,
  });

  factory StorageCreateModel.fromJson(Map<String, dynamic> json) =>
      _$StorageCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$StorageCreateModelToJson(this);

  final String name;
  final String? description;
}
