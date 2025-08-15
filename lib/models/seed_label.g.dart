// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeedLabel _$SeedLabelFromJson(Map<String, dynamic> json) => SeedLabel(
      id: json['id'] as int?,
      applicantRemarks: json['applicant_remarks'] as String?,
      quantity: json['quantity'] as String?,
      cropVarietyText: json['crop_variety_text'] as String?,
      status: json['status'] as String?,
      availableStock: json['available_stock'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$SeedLabelToJson(SeedLabel instance) => <String, dynamic>{
      'id': instance.id,
      'applicant_remarks': instance.applicantRemarks,
      'quantity': instance.quantity,
      'available_stock': instance.availableStock,
      'crop_variety_text': instance.cropVarietyText,
      'status': instance.status,
      'created_at': instance.createdAt,
    };
