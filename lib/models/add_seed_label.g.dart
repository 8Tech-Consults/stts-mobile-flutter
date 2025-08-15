// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_seed_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSeedLabel _$AddSeedLabelFromJson(Map<String, dynamic> json) => AddSeedLabel(
      administratorId: json['administrator_id'] as int?,
      seedLabId: json['seed_lab_id'] as int?,
      seedLabelPackageId: json['seed_label_package_id'] as int?,
      availableStock: json['available_stock'] as int?,
      receipt: json['receipt'] as String?,
      applicantRemarks: json['applicant_remarks'] as String?,
      image: json['image'] as String?,
      quantity: json['quantity'] as int?,
      status: json['status'] as int?,
      statusComment: json['status_comment'] as String?,
    );

Map<String, dynamic> _$AddSeedLabelToJson(AddSeedLabel instance) =>
    <String, dynamic>{
      'administrator_id': instance.administratorId,
      'seed_lab_id': instance.seedLabId,
      'seed_label_package_id': instance.seedLabelPackageId,
      'available_stock': instance.availableStock,
      'receipt': instance.receipt,
      'applicant_remarks': instance.applicantRemarks,
      'image': instance.image,
      'quantity': instance.quantity,
      'status': instance.status,
      'status_comment': instance.statusComment,
    };
