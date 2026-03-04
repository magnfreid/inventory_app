import 'package:user_remote/user_remote.dart';

/// Roles a [User] can have.
enum UserRole {
  ///Admin role.
  admin,

  ///Standard user role.
  user,
}

/// Domain model representing a user in an organization.
class User {
  /// Creates a [User] instance.
  User({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.role,
  });

  /// Creates a [User] from a [UserDto].
  ///
  /// Maps the DTO's role to the domain [UserRole].
  factory User.fromDto(UserDto dto) => User(
    id: dto.id,
    organizationId: dto.organizationId,
    name: dto.name,
    email: dto.email,
    role: switch (dto.role) {
      .admin => UserRole.admin,
      .user => UserRole.user,
    },
  );

  /// Unique ID of the user.
  final String id;

  /// ID of the organization the user belongs to.
  final String organizationId;

  /// Display name of the user.
  final String name;

  /// Email address of the user.
  final String email;

  /// Role of the user within the organization.
  final UserRole role;
}
