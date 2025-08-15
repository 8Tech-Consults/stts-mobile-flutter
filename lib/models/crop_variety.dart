import 'package:json_annotation/json_annotation.dart';
part 'crop_variety.g.dart';

@JsonSerializable()
class CropVariety {
  int? id;
  String? name;

  CropVariety({
    this.id,
    this.name,
  });
  Map toJson() {
    return _$CropVarietyToJson(this);
  }

  factory CropVariety.fromJson(Map<String, dynamic> json) {
    return _$CropVarietyFromJson(json);
  }
}
