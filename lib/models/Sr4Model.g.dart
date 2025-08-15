// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Sr4Model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SrModel _$SrModelFromJson(Map<String, dynamic> json) => SrModel(
      status: json['status'] as String?,
      nameOfApplicant: json['name_of_applicant'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      statusComment: json['status_comment'] as String?,
      seedBoardRegistrationNumber:
          json['seed_board_registration_number'] as String?,
      growerNumber: json['grower_number'] as String?,
    );

Map<String, dynamic> _$SrModelToJson(SrModel instance) => <String, dynamic>{
      'name_of_applicant': instance.nameOfApplicant,
      'created_at': instance.createdAt,
      'status_comment': instance.statusComment,
      'seed_board_registration_number': instance.seedBoardRegistrationNumber,
      'status': instance.status,
      'type': instance.type,
      'grower_number': instance.growerNumber,
    };
