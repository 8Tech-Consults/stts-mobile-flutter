// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) => Form(
      id: json['id'] as int?,
      status: json['status'] as String?,
      cropVariety: json['crop_variety'] == null
          ? null
          : CropVariety.fromJson(json['crop_variety'] as Map<String, dynamic>),
      sizeOfField: json['size_of_field'] as String?,
      minDate: json['min_date'] as String?,
      sr10Number: json['sr10_number'] as String?,
      stage: json['stage'] as String?,
      qdsDeclarationId: json['qds_declaration_id'] as String?,
    );

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'stage': instance.stage,
      'crop_variety': instance.cropVariety,
      'size_of_field': instance.sizeOfField,
      'min_date': instance.minDate,
      'sr10_number': instance.sr10Number,
      'qds_declaration_id': instance.qdsDeclarationId,
    };
