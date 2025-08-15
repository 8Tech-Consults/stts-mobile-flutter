import 'package:json_annotation/json_annotation.dart';
part 'stock_exam_form.g.dart';

@JsonSerializable()
class StockExamForm {
  int? id;
  @JsonKey(name: 'field_size')
  String? fieldSize;
  String? yield;
  String? date;
  String? status;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  @JsonKey(name: 'created_at')
  String? createdAt;

  StockExamForm({
    this.id,
    this.fieldSize,
    this.yield,
    this.date,
    this.status,
    this.lotNumber,
    this.createdAt,
  });
  Map toJson() {
    return _$StockExamFormToJson(this);
  }

  factory StockExamForm.fromJson(Map<String, dynamic> json) {
    return _$StockExamFormFromJson(json);
  }
}
