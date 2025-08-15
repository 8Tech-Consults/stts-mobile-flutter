// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_stock_exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStockExam _$AddStockExamFromJson(Map<String, dynamic> json) => AddStockExam(
      administratorId: json['administrator_id'] as int?,
      importExportPermitId: json['import_export_permit_id'] as int?,
      lotNumber: json['lot_number'] as String?,
      remarks: json['remarks'] as String?,
      cropVarietyId: json['crop_variety_id'] as int?,
      plantingReturnId: json['planting_return_id'] as int?,
      formQdsId: json['form_qds_id'] as int?,
    );

Map<String, dynamic> _$AddStockExamToJson(AddStockExam instance) =>
    <String, dynamic>{
      'administrator_id': instance.administratorId,
      'import_export_permit_id': instance.importExportPermitId,
      'lot_number': instance.lotNumber,
      'remarks': instance.remarks,
      'crop_variety_id': instance.cropVarietyId,
      'planting_return_id': instance.plantingReturnId,
      'form_qds_id': instance.formQdsId,
    };
