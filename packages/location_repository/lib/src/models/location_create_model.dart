import 'package:json_annotation/json_annotation.dart';

part 'location_create_model.g.dart';

@JsonSerializable()
class LocationCreateModel {
  LocationCreateModel({
    required this.name,
    required this.description,
  });

  factory LocationCreateModel.fromJson(Map<String, dynamic> json) =>
      _$LocationCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationCreateModelToJson(this);

  final String name;
  final String? description;
}
