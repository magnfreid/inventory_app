// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['id'] as String,
  organizationId: json['organizationId'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$UserDtoRoleEnumMap, json['role']),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'organizationId': instance.organizationId,
  'name': instance.name,
  'email': instance.email,
  'role': _$UserDtoRoleEnumMap[instance.role]!,
};

const _$UserDtoRoleEnumMap = {
  UserDtoRole.admin: 'admin',
  UserDtoRole.user: 'user',
};
