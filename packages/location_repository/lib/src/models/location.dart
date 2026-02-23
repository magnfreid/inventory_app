import 'package:json_annotation/json_annotation.dart';
import 'package:location_repository/src/models/location_create_model.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location({required this.id, required this.name, this.description});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  factory Location.fromCreateModel({
    required String id,
    required LocationCreateModel createModel,
  }) => Location(
    id: id,
    name: createModel.name,
    description: createModel.description,
  );

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final String id;
  final String name;
  String? description;
}
