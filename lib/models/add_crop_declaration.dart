import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_crop_declaration.g.dart';

@JsonSerializable()
class AddCropDeclaration {
  @JsonKey(name: 'field_size')
  int? fieldSize;
  @JsonKey(name: 'source_of_seed')
  String? sourceOfSeed;
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  @JsonKey(name: 'seed_rate')
  int? seedRate;
  int? amount;
  String? status;
  @JsonKey(name: 'payment_receipt')
  String? paymentReceipt;
  @JsonKey(name: 'form_qd_id')
  int? formQdId;
  @JsonKey(name: 'inspector_id')
  int? inspectorId;
  @JsonKey(name: 'form_crop_declarations_has_crop_varieties')
  List<Map<String, dynamic>>? cropVarieties;

  AddCropDeclaration({
    this.status,
    this.sourceOfSeed,
    this.administratorId,
    this.paymentReceipt,
    this.seedRate,
    this.fieldSize,
    this.amount,
    this.formQdId,
    this.inspectorId,
    this.cropVarieties,
  });
  Map toJson() {
    return _$AddCropDeclarationToJson(this);
  }

  factory AddCropDeclaration.fromJson(Map<String, dynamic> json) {
    return _$AddCropDeclarationFromJson(json);
  }
}
