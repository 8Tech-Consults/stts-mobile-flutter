import 'package:json_annotation/json_annotation.dart';
part 'crop_declaration.g.dart';

@JsonSerializable()
class CropDeclaration {
  int? id;
  @JsonKey(name: 'field_size')
  String? fieldSize;
  @JsonKey(name: 'source_of_seed')
  String? sourceofSeed;
  String? status;
  String? amount;

  CropDeclaration({
    this.id,
    this.fieldSize,
    this.sourceofSeed,
    this.status,
    this.amount,
  });
  Map toJson() {
    return _$CropDeclarationToJson(this);
  }

  factory CropDeclaration.fromJson(Map<String, dynamic> json) {
    return _$CropDeclarationFromJson(json);
  }
}
