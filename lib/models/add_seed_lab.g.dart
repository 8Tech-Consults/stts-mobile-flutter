// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_seed_lab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSeedLab _$AddSeedLabFromJson(Map<String, dynamic> json) => AddSeedLab(
      administratorId: json['administrator_id'] as int?,
      cropVarietyId: json['crop_variety_id'] as int?,
      formStockExaminationRequestId:
          json['form_stock_examination_request_id'] as int?,
      collectionDate: json['collection_date'] as String?,
      paymentReceipt: json['payment_receipt'] as String?,
      applicantRemarks: json['applicant_remarks'] as String?,
    );

Map<String, dynamic> _$AddSeedLabToJson(AddSeedLab instance) =>
    <String, dynamic>{
      'administrator_id': instance.administratorId,
      'crop_variety_id': instance.cropVarietyId,
      'form_stock_examination_request_id':
          instance.formStockExaminationRequestId,
      'collection_date': instance.collectionDate,
      'payment_receipt': instance.paymentReceipt,
      'applicant_remarks': instance.applicantRemarks,
    };
