import 'package:user_remote/user_remote.dart';

enum UserRole { admin, user }

class User {
  User({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromDto(UserDto dto) => User(
    id: dto.id,
    organizationId: dto.organizationId,
    name: dto.name,
    email: dto.email,
    role: switch (dto.role) {
      .admin => .admin,
      .user => .admin,
    },
  );

  final String id;
  final String organizationId;
  final String name;
  final String email;
  final UserRole role;
}
