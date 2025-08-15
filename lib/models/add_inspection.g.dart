// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInspection _$AddInspectionFromJson(Map<String, dynamic> json) =>
    AddInspection(
      status: json['status'] as int?,
      stage: json['stage'] as int?,
      statusComment: json['status_comment'] as String?,
      sr10Number: json['sr10_number'] as String?,
      plantingReturnCropName: json['planting_return_crop_name'] as String?,
      seedClass: json['seed_class'] as String?,
      sizeOfField: json['size_of_field'] as String?,
      offTypes: json['off_types'] as String?,
      diseases: json['diseases'] as String?,
      noxiousWeeds: json['noxious_weeds'] as String?,
      otherFeatures: json['other_features'] as String?,
      otherWeeds: json['other_weeds'] as String?,
      femaleReceptive: json['female_receptive'] as bool?,
      isolationDistance: json['isolation_distance'] as String?,
      variety: json['variety'] as String?,
      proposedDistance: json['proposed_distance'] as String?,
      generalConditionsOfCrop: json['general_conditions_of_crop'] as String?,
      estimatedYield: json['estimated_yield'] as String?,
      furtherRemaks: json['further_remaks'] as String?,
    );

Map<String, dynamic> _$AddInspectionToJson(AddInspection instance) =>
    <String, dynamic>{
      'status': instance.status,
      'stage': instance.stage,
      'status_comment': instance.statusComment,
      'sr10_number': instance.sr10Number,
      'planting_return_crop_name': instance.plantingReturnCropName,
      'seed_class': instance.seedClass,
      'size_of_field': instance.sizeOfField,
      'off_types': instance.offTypes,
      'diseases': instance.diseases,
      'noxious_weeds': instance.noxiousWeeds,
      'other_features': instance.otherFeatures,
      'other_weeds': instance.otherWeeds,
      'female_receptive': instance.femaleReceptive,
      'isolation_distance': instance.isolationDistance,
      'variety': instance.variety,
      'proposed_distance': instance.proposedDistance,
      'general_conditions_of_crop': instance.generalConditionsOfCrop,
      'estimated_yield': instance.estimatedYield,
      'further_remaks': instance.furtherRemaks,
    };
