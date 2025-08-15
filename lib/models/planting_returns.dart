import 'package:json_annotation/json_annotation.dart';
part 'planting_returns.g.dart';

@JsonSerializable()
class PlantingReturns {
  int? id;
  String? name;
  String? size;
  String? status;

  PlantingReturns({
    this.id,
    this.name,
    this.size,
    this.status,
  });
  Map toJson() {
    return _$PlantingReturnsToJson(this);
  }

  factory PlantingReturns.fromJson(Map<String, dynamic> json) {
    return _$PlantingReturnsFromJson(json);
  }
}
