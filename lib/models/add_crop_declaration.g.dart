// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_crop_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCropDeclaration _$AddCropDeclarationFromJson(Map<String, dynamic> json) =>
    AddCropDeclaration(
      status: json['status'] as String?,
      sourceOfSeed: json['source_of_seed'] as String?,
      administratorId: json['administrator_id'] as int?,
      paymentReceipt: json['payment_receipt'] as String?,
      seedRate: json['seed_rate'] as int?,
      fieldSize: json['field_size'] as int?,
      amount: json['amount'] as int?,
      formQdId: json['form_qd_id'] as int?,
      inspectorId: json['inspector_id'] as int?,
      cropVarieties:
          (json['form_crop_declarations_has_crop_varieties'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList(),
    );

Map<String, dynamic> _$AddCropDeclarationToJson(AddCropDeclaration instance) =>
    <String, dynamic>{
      'field_size': instance.fieldSize,
      'source_of_seed': instance.sourceOfSeed,
      'administrator_id': instance.administratorId,
      'seed_rate': instance.seedRate,
      'amount': instance.amount,
      'status': instance.status,
      'payment_receipt': instance.paymentReceipt,
      'form_qd_id': instance.formQdId,
      'inspector_id': instance.inspectorId,
      'form_crop_declarations_has_crop_varieties': instance.cropVarieties,
    };
