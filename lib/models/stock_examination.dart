import 'package:STTS/models/import_permit.dart';
import 'package:STTS/models/stock_exam_form.dart';
import 'package:json_annotation/json_annotation.dart';
part 'stock_examination.g.dart';

@JsonSerializable()
class StockExamination {
  @JsonKey(name: 'form')
  StockExamForm? stockExamForm;
  @JsonKey(name: 'import_permits')
  ImportPermit? importPermit;

  StockExamination({
    this.stockExamForm,
    this.importPermit,
  });
  Map toJson() {
    return _$StockExaminationToJson(this);
  }

  factory StockExamination.fromJson(Map<String, dynamic> json) {
    return _$StockExaminationFromJson(json);
  }
}
