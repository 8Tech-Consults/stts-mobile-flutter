// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_planting_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPlantingReturn _$AddPlantingReturnFromJson(Map<String, dynamic> json) =>
    AddPlantingReturn(
      detail: json['detail'] as String?,
      gpsLongitude: json['gps_longitude'] as String?,
      gpsLatitude: json['gps_latitude'] as String?,
      expectedYield: json['expected_yield'] as int?,
      village: json['village'] as String?,
      plantingDate: json['planting_date'] as String?,
      quantityPlanted: json['quantity_planted'] as int?,
      administratorId: json['administrator_id'] as int?,
      name: json['name'] as String?,
      size: json['size'] as int?,
      crop: json['crop'] as String?,
      variety: json['variety'] as String?,
      seedClass: json['seed_class'] as String?,
      lotNumber: json['lot_number'] as String?,
      sourceOfSeed: json['source_of_seed'] as String?,
      fieldName: json['field_name'] as String?,
      district: json['district'] as String?,
      subcounty: json['subcounty'] as String?,
      phoneNumber: json['phone_number'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AddPlantingReturnToJson(AddPlantingReturn instance) =>
    <String, dynamic>{
      'administrator_id': instance.administratorId,
      'name': instance.name,
      'size': instance.size,
      'crop': instance.crop,
      'variety': instance.variety,
      'seed_class': instance.seedClass,
      'lot_number': instance.lotNumber,
      'source_of_seed': instance.sourceOfSeed,
      'field_name': instance.fieldName,
      'district': instance.district,
      'subcounty': instance.subcounty,
      'village': instance.village,
      'planting_date': instance.plantingDate,
      'quantity_planted': instance.quantityPlanted,
      'expected_yield': instance.expectedYield,
      'phone_number': instance.phoneNumber,
      'gps_latitude': instance.gpsLatitude,
      'gps_longitude': instance.gpsLongitude,
      'detail': instance.detail,
      'status': instance.status,
    };
