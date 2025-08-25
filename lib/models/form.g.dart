// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) => Form(
      id: json['id'] as int?,
      status: json['status'] as String?,
      seedClass: json['seed_class'] as String?,
      cropVariety: json['crop_variety'] == null
          ? null
          : CropVariety.fromJson(json['crop_variety'] as Map<String, dynamic>),
      sizeOfField: json['size_of_field'] as String?,
      offTypes: json['off_types'] as String?,
      diseases: json['diseases'] as String?,
      noxiousWeeds: json['noxious_weeds'] as String?,
      otherFeatures: json['other_features'] as String?,
      otherWeeds: json['other_weeds'] as String?,
      femaleReceptive: json['female_receptive'] as bool?,
      isolationDistance: json['isolation_distance'] as String?,
      proposedDistance: json['proposed_distance'] as String?,
      generalConditionsOfCrop: json['general_conditions_of_crop'] as String?,
      plantCount: json['plant_count'] as String?,
      estimatedYield: json['estimated_yield'] as String?,
      furtherRemaks: json['further_remaks'] as String?,
      minDate: json['min_date'] as String?,
      sr10Number: json['sr10_number'] as String?,
      stage: json['stage'] as String?,
      qdsDeclarationId: json['qds_declaration_id'] as String?,
    );

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'stage': instance.stage,
      'seed_class': instance.seedClass,
      'crop_variety': instance.cropVariety,
      'size_of_field': instance.sizeOfField,
      'off_types': instance.offTypes,
      'diseases': instance.diseases,
      'noxious_weeds': instance.noxiousWeeds,
      'other_features': instance.otherFeatures,
      'other_weeds': instance.otherWeeds,
      'female_receptive': instance.femaleReceptive,
      'isolation_distance': instance.isolationDistance,
      'proposed_distance': instance.proposedDistance,
      'general_conditions_of_crop': instance.generalConditionsOfCrop,
      'plant_count': instance.plantCount,
      'estimated_yield': instance.estimatedYield,
      'further_remaks': instance.furtherRemaks,
      'min_date': instance.minDate,
      'sr10_number': instance.sr10Number,
      'qds_declaration_id': instance.qdsDeclarationId,
    };
