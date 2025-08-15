// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_sample_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSampleAnalysis _$AddSampleAnalysisFromJson(Map<String, dynamic> json) =>
    AddSampleAnalysis(
      sampleWeight: json['sample_weight'] as int?,
      packaging: json['packaging'] as String?,
      motherLot: json['mother_lot'] as String?,
      sampleCondition: json['sample_condition'] as String?,
      testsRequired: json['tests_required'] as String?,
      status: json['status'] as int?,
      reportRecommendation: json['report_recommendation'] as int?,
    );

Map<String, dynamic> _$AddSampleAnalysisToJson(AddSampleAnalysis instance) =>
    <String, dynamic>{
      'sample_weight': instance.sampleWeight,
      'packaging': instance.packaging,
      'mother_lot': instance.motherLot,
      'sample_condition': instance.sampleCondition,
      'tests_required': instance.testsRequired,
      'status': instance.status,
      'report_recommendation': instance.reportRecommendation,
    };
