// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      productId: json['product_id'] as String?,
      quantity: json['quantity'] as String?,
      cropVarietyText: json['crop_variety_text'] as String?,
      status: json['status'] as String?,
      cropVariety: json['crop_variety'] == null
          ? null
          : CropVariety.fromJson(json['crop_variety'] as Map<String, dynamic>),
      seedClass: json['seed_class'] as String?,
      pickupLocation: json['pickup_location'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'crop_variety': instance.cropVariety,
      'crop_variety_text': instance.cropVarietyText,
      'seed_class': instance.seedClass,
      'pickup_location': instance.pickupLocation,
      'status': instance.status,
    };
