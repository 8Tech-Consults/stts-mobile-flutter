import 'package:json_annotation/json_annotation.dart';
part 'crop.g.dart';

@JsonSerializable()
class Crop {
  int? id;
  String? name;

  Crop({
    this.id,
    this.name,
  });
  Map toJson() {
    return _$CropToJson(this);
  }

  factory Crop.fromJson(Map<String, dynamic> json) {
    return _$CropFromJson(json);
  }
}
