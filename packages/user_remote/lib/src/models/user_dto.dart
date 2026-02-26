import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

enum UserDtoRole { admin, user }

@JsonSerializable()
class UserDto {
  UserDto({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  final String id;
  final String organizationId;
  final String name;
  final String email;
  final UserDtoRole role;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
