// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_sub_grower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedInpection _$AssignedInpectionFromJson(Map<String, dynamic> json) =>
    AssignedInpection(
      assignedSubGrower: json['subgrower form'] == null
          ? null
          : AssignedSubGrower.fromJson(
              json['subgrower form'] as Map<String, dynamic>),
      plantingReturns: json['planting_return'] == null
          ? null
          : PlantingReturns.fromJson(
              json['planting_return'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssignedInpectionToJson(AssignedInpection instance) =>
    <String, dynamic>{
      'subgrower form': instance.assignedSubGrower,
      'planting_return': instance.plantingReturns,
    };

AssignedSubGrower _$AssignedSubGrowerFromJson(Map<String, dynamic> json) =>AssignedSubGrower(
      id: json['id'] as int?,
      name: json['name'] as String?,
      gpsLatitude: json['gps_latitude'] as String?,
      gpsLongitude: json['gps_longitude'] as String?,
      status: json['status'] as String?,
      variety: json['variety'] as String?,
      size: json['size'] as String?,
      plantingdate: json['planting_date'] as String?,
    //   crop: json['crop'] as String,
      crop: json['crop_obj']== null
          ? null
          : Crop.fromJson(json['crop_obj'] as Map<String, dynamic>),
      
    );

Map<String, dynamic> _$AssignedSubGrowerToJson(AssignedSubGrower instance) 
  =><String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gps_latitude': instance.gpsLatitude,
      'gps_longitude': instance.gpsLongitude,
      'planting_date': instance.plantingdate,
      'status': instance.status,
      'variety': instance.variety,
      'size': instance.size,
      'crop_obj': instance.crop,
      
    };
