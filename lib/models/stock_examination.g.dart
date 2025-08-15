// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_examination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockExamination _$StockExaminationFromJson(Map<String, dynamic> json) =>
    StockExamination(
      stockExamForm: json['form'] == null
          ? null
          : StockExamForm.fromJson(json['form'] as Map<String, dynamic>),
      importPermit: json['import_permits'] == null
          ? null
          : ImportPermit.fromJson(
              json['import_permits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockExaminationToJson(StockExamination instance) =>
    <String, dynamic>{
      'form': instance.stockExamForm,
      'import_permits': instance.importPermit,
    };
