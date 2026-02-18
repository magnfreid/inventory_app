import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum UserRole { admin, user }

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirestore(
    Map<String, dynamic> json,
    String id,
  ) {
    return User.fromJson({
      ...json,
      'id': id,
    });
  }

  final String id;
  final String organizationId;
  final String name;
  final String email;
  final UserRole role;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
