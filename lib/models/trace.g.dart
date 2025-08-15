// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trace _$TraceFromJson(Map<String, dynamic> json) => Trace(
      crop: json['crop'] as String?,
      brokenGerms: json['broken_germs'] as String?,
      cropVariety: json['crop_variety'] == null
          ? null
          : CropVariety.fromJson(json['crop_variety'] as Map<String, dynamic>),
      lotNumber: json['lot_number'] as String?,
      collectionDate: json['collection_date'] as String?,
      labTestNumber: json['lab_test_number'] as String?,
      seedClass: json['seed_class'] as String?,
      germinationCapacity: json['germination_capacity'] as String?,
      testDate: json['test_date'] as String?,
    );

Map<String, dynamic> _$TraceToJson(Trace instance) => <String, dynamic>{
      'crop': instance.crop,
      'broken_germs': instance.brokenGerms,
      'lot_number': instance.lotNumber,
      'crop_variety': instance.cropVariety,
      'collection_date': instance.collectionDate,
      'lab_test_number': instance.labTestNumber,
      'seed_class': instance.seedClass,
      'germination_capacity': instance.germinationCapacity,
      'test_date': instance.testDate,
    };
