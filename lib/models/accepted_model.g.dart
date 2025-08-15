// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptedModel _$AcceptedModelFromJson(Map<String, dynamic> json) =>
    AcceptedModel(
      id: json['id'],
      permitNumber: json['permit_number'] as String?,
      text: json['text'] as String?,
      fieldName: json['field_name'] as String?,
      sr10Number: json['sr10_number'] as String?,
      cropVarietyId: json['crop_variety_id'] as String?,
    );

Map<String, dynamic> _$AcceptedModelToJson(AcceptedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'permit_number': instance.permitNumber,
      'text': instance.text,
      'field_name': instance.fieldName,
      'sr10_number': instance.sr10Number,
      'crop_variety_id': instance.cropVarietyId,
    };
