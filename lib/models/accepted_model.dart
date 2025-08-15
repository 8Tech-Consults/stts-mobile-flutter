import 'package:json_annotation/json_annotation.dart';
part 'accepted_model.g.dart';

@JsonSerializable()
class AcceptedModel {
  dynamic id;
  @JsonKey(name: 'permit_number')
  String? permitNumber;
  String? text;
  @JsonKey(name: 'field_name')
  String? fieldName;
  @JsonKey(name: 'sr10_number')
  String? sr10Number;
  @JsonKey(name: 'crop_variety_id')
  String? cropVarietyId;

  AcceptedModel({
    this.id,
    this.permitNumber,
    this.text,
    this.fieldName,
    this.sr10Number,
    this.cropVarietyId,
  });
  Map toJson() {
    return _$AcceptedModelToJson(this);
  }

  factory AcceptedModel.fromJson(Map<String, dynamic> json) {
    return _$AcceptedModelFromJson(json);
  }
}
