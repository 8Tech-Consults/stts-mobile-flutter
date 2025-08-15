// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropDeclaration _$CropDeclarationFromJson(Map<String, dynamic> json) =>
    CropDeclaration(
      id: json['id'] as int?,
      fieldSize: json['field_size'] as String?,
      sourceofSeed: json['source_of_seed'] as String?,
      status: json['status'] as String?,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$CropDeclarationToJson(CropDeclaration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field_size': instance.fieldSize,
      'source_of_seed': instance.sourceofSeed,
      'status': instance.status,
      'amount': instance.amount,
    };
