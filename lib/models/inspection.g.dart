// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inspection _$InspectionFromJson(Map<String, dynamic> json) => Inspection(
      form: json['form'] == null
          ? null
          : Form.fromJson(json['form'] as Map<String, dynamic>),
      subGrower: json['subgrower'] == null
          ? null
          : SubGrower.fromJson(json['subgrower'] as Map<String, dynamic>),
      inspectionType: json['inspection_type'] as String?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$InspectionToJson(Inspection instance) =>
    <String, dynamic>{
      'form': instance.form,
      'subgrower': instance.subGrower,
      'inspection_type': instance.inspectionType,
      'user': instance.user,
    };
