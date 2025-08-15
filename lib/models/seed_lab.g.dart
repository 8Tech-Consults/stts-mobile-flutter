// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_lab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeedLab _$SeedLabFromJson(Map<String, dynamic> json) => SeedLab(
      id: json['id'] as int?,
      collectionDate: json['collection_date'] as String?,
      applicantRemarks: json['applicant_remarks'] as String?,
      quantity: json['quantity'] as String?,
      lotNumber: json['lot_number'] as String?,
      cropVarietyText: json['crop_variety_text'] as String?,
      testsRequired: json['tests_required'] as String?,
      createdAt: json['created_at'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SeedLabToJson(SeedLab instance) => <String, dynamic>{
      'id': instance.id,
      'collection_date': instance.collectionDate,
      'created_at': instance.createdAt,
      'applicant_remarks': instance.applicantRemarks,
      'quantity': instance.quantity,
      'lot_number': instance.lotNumber,
      'crop_variety_text': instance.cropVarietyText,
      'tests_required': instance.testsRequired,
      'status': instance.status,
    };
