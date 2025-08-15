// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatar: json['avatar'] as String,
      token: json['token'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'token': instance.token,
      'roles': instance.roles,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
