import 'package:json_annotation/json_annotation.dart';
part 'lab_test_number.g.dart';

@JsonSerializable()
class LabTestNumber {
  int? id;
  @JsonKey(name: 'lab_test_number')
  String? labTestNumber;

  LabTestNumber({
    this.id,
    this.labTestNumber,
  });
  Map toJson() {
    return _$LabTestNumberToJson(this);
  }

  factory LabTestNumber.fromJson(Map<String, dynamic> json) {
    return _$LabTestNumberFromJson(json);
  }
}
