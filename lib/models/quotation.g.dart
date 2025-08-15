// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quotation _$QuotationFromJson(Map<String, dynamic> json) => Quotation(
      id: json['id'] as int?,
      seedClass: json['seed_class'] as String?,
      supplyDate: json['supply_date'] as String?,
      price: json['price'] as String?,
      cropVariety: json['crop_variety'] == null
          ? null
          : CropVariety.fromJson(json['crop_variety'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$QuotationToJson(Quotation instance) => <String, dynamic>{
      'id': instance.id,
      'supply_date': instance.supplyDate,
      'seed_class': instance.seedClass,
      'price': instance.price,
      'crop_variety': instance.cropVariety,
      'status': instance.status,
      'quantity': instance.quantity,
    };
