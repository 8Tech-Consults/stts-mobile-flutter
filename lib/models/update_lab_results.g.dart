// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_lab_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLabResults _$UpdateLabResultsFromJson(Map<String, dynamic> json) =>
    UpdateLabResults(
      purity: json['purity'] as int?,
      brokenGerms: json['broken_germss'] as int?,
      quantity: json['quantity'] as int?,
      germinationCapacity: json['germination_capacity'] as int?,
      abnormalSprouts: json['abnormal_sprouts'] as int?,
      reportRecommendation: json['report_recommendation'] as String?,
      receptionistIsDone: json['receptionist_is_done'] as bool?,
    );

Map<String, dynamic> _$UpdateLabResultsToJson(UpdateLabResults instance) =>
    <String, dynamic>{
      'purity': instance.purity,
      'quantity': instance.quantity,
      'germination_capacity': instance.germinationCapacity,
      'abnormal_sprouts': instance.abnormalSprouts,
      'broken_germss': instance.brokenGerms,
      'report_recommendation': instance.reportRecommendation,
      'receptionist_is_done': instance.receptionistIsDone,
    };
