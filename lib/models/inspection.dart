import 'package:STTS/models/form.dart';
import 'package:STTS/models/subgrower.dart';
import 'package:json_annotation/json_annotation.dart';
part 'inspection.g.dart';

@JsonSerializable()
class Inspection {
  Form? form;
  @JsonKey(name: 'subgrower')
  SubGrower? subGrower;
  @JsonKey(name: 'inspection_type')
  String? inspectionType;
  String? user;
  Inspection({
    this.form,
    this.subGrower,
    this.inspectionType,
    this.user,
  });
  Map toJson() {
    return _$InspectionToJson(this);
  }

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return _$InspectionFromJson(json);
  }
}
