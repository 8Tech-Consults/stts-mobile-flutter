// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subgrower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubGrower _$SubGrowerFromJson(Map<String, dynamic> json) => SubGrower(
      id: json['id'] as int?,
      lotNumber: json['lot_number'] as String?,
      gpsLatitude: json['gps_latitude'] as String?,
      gpsLongitude: json['gps_longitude'] as String?,
      plantingDate: json['planting_date'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SubGrowerToJson(SubGrower instance) => <String, dynamic>{
      'id': instance.id,
      'lot_number': instance.lotNumber,
      'gps_latitude': instance.gpsLatitude,
      'gps_longitude': instance.gpsLongitude,
      'planting_date': instance.plantingDate,
      'name': instance.name,
    };
