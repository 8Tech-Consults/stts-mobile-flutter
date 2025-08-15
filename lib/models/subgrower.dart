import 'package:json_annotation/json_annotation.dart';
part 'subgrower.g.dart';

@JsonSerializable()
class SubGrower {
  int? id;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  @JsonKey(name: 'gps_latitude')
  String? gpsLatitude;
  @JsonKey(name: 'gps_longitude')
  String? gpsLongitude;
  @JsonKey(name: 'planting_date')
  String? plantingDate;
  String? name;

  SubGrower({
    this.id,
    this.lotNumber,
    this.gpsLatitude,
    this.gpsLongitude,
    this.plantingDate,
    this.name,
  });
  Map toJson() {
    return _$SubGrowerToJson(this);
  }

  factory SubGrower.fromJson(Map<String, dynamic> json) {
    return _$SubGrowerFromJson(json);
  }
}
