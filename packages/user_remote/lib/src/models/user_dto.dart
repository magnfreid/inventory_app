import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

/// Role values used in the remote data layer for a user.
enum UserDtoRole {
  /// Administrator with elevated permissions.
  admin,

  /// Regular user with standard permissions.
  user,
}

/// Data Transfer Object representing a user.
@JsonSerializable()
class UserDto {
  /// Creates a [UserDto].
  UserDto({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.role,
  });

  /// Creates a [UserDto] from a JSON map.
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Unique identifier of the user.
  ///
  /// May be `null` when creating a new user before it is persisted.
  final String? id;

  /// ID of the organization the user belongs to.
  final String organizationId;

  /// Display name of the user.
  final String name;

  /// Email address of the user.
  final String email;

  /// Role of the user in the remote layer.
  final UserDtoRole role;

  /// Converts this [UserDto] to a JSON map.
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
