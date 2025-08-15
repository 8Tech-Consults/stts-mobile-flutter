// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeedStock _$SeedStockFromJson(Map<String, dynamic> json) => SeedStock(
      user: json['user'] as String?,
      cropVariety: json['crop_variety'] as String?,
      seedId: json['id'] == null
          ? null
          : SeedId.fromJson(json['id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeedStockToJson(SeedStock instance) => <String, dynamic>{
      'user': instance.user,
      'crop_variety': instance.cropVariety,
      'id': instance.seedId,
    };

SeedId _$SeedIdFromJson(Map<String, dynamic> json) => SeedId(
      source: json['source'] as String?,
      quantity: json['quantity'] as String?,
      lotNumber: json['lot_number'] as String?,
    );

Map<String, dynamic> _$SeedIdToJson(SeedId instance) => <String, dynamic>{
      'source': instance.source,
      'quantity': instance.quantity,
      'lot_number': instance.lotNumber,
    };
