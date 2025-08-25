// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUser _$AddUserFromJson(Map<String, dynamic> json) => AddUser(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      district: json['district'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AddUserToJson(AddUser instance) => <String, dynamic>{
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'district': instance.district,
    };
