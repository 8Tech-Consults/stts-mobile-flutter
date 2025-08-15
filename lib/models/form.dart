import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'form.g.dart';

@JsonSerializable()
class Form {
  int? id;
  String? status;
  String? stage;
  @JsonKey(name: 'crop_variety')
  CropVariety? cropVariety;
  @JsonKey(name: 'size_of_field')
  String? sizeOfField;
  @JsonKey(name: 'min_date')
  String? minDate;
  @JsonKey(name: 'sr10_number')
  String? sr10Number;
  @JsonKey(name: 'qds_declaration_id')
  String? qdsDeclarationId;

  Form({
    this.id,
    this.status,
    this.cropVariety,
    this.sizeOfField,
    this.minDate,
    this.sr10Number,
    this.stage,
    this.qdsDeclarationId,
  });
  Map toJson() {
    return _$FormToJson(this);
  }

  factory Form.fromJson(Map<String, dynamic> json) {
    return _$FormFromJson(json);
  }
}
