// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_label_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeedLabelPackage _$SeedLabelPackageFromJson(Map<String, dynamic> json) =>
    SeedLabelPackage(
      id: json['id'] as int?,
      packageSize: json['package_size'] as String?,
      packagePrice: json['package_price'] as String?,
    );

Map<String, dynamic> _$SeedLabelPackageToJson(SeedLabelPackage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package_size': instance.packageSize,
      'package_price': instance.packagePrice,
    };
