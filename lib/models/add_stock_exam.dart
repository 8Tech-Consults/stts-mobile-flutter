import 'package:json_annotation/json_annotation.dart';
part 'add_stock_exam.g.dart';

@JsonSerializable()
class AddStockExam {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  @JsonKey(name: 'import_export_permit_id')
  int? importExportPermitId;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  String? remarks;
  @JsonKey(name: 'crop_variety_id')
  int? cropVarietyId;
  @JsonKey(name: 'planting_return_id')
  int? plantingReturnId;
  @JsonKey(name: 'form_qds_id')
  int? formQdsId;

  AddStockExam({
    this.administratorId,
    this.importExportPermitId,
    this.lotNumber,
    this.remarks,
    this.cropVarietyId,
    this.plantingReturnId,
    this.formQdsId,
  });
  Map toJson() {
    return _$AddStockExamToJson(this);
  }

  factory AddStockExam.fromJson(Map<String, dynamic> json) {
    return _$AddStockExamFromJson(json);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'administrator_id': administratorId});
    result.addAll({'import_export_permit_id': importExportPermitId});
    result.addAll({'lot_number': lotNumber});
    return result;
  }
}
