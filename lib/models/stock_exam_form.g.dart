// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_exam_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockExamForm _$StockExamFormFromJson(Map<String, dynamic> json) =>
    StockExamForm(
      id: json['id'] as int?,
      fieldSize: json['field_size'] as String?,
      yield: json['yield'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
      lotNumber: json['lot_number'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$StockExamFormToJson(StockExamForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field_size': instance.fieldSize,
      'yield': instance.yield,
      'date': instance.date,
      'status': instance.status,
      'lot_number': instance.lotNumber,
      'created_at': instance.createdAt,
    };
