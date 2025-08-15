// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOrder _$AddOrderFromJson(Map<String, dynamic> json) => AddOrder(
      administratorId: json['administrator_id'] as int?,
      orderBy: json['order_by'] as int?,
      cropVarietyId: json['crop_variety_id'] as int?,
      seedClass: json['seed_class'] as String?,
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      detail: json['detail'] as String?,
      paymentType: json['payment_type'] as String?,
      totalPrice: json['total_price'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$AddOrderToJson(AddOrder instance) => <String, dynamic>{
      'administrator_id': instance.administratorId,
      'order_by': instance.orderBy,
      'crop_variety_id': instance.cropVarietyId,
      'seed_class': instance.seedClass,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'detail': instance.detail,
      'payment_type': instance.paymentType,
      'total_price': instance.totalPrice,
      'status': instance.status,
    };
