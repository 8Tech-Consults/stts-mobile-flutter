// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportExport _$ImportExportFromJson(Map<String, dynamic> json) => ImportExport(
      id: json['id'] as int?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      telephone: json['telephone'] as String?,
      status: json['status'] as String?,
      quantiryOfSeed: json['quantiry_of_seed'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ImportExportToJson(ImportExport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'telephone': instance.telephone,
      'status': instance.status,
      'quantiry_of_seed': instance.quantiryOfSeed,
      'created_at': instance.createdAt,
    };
