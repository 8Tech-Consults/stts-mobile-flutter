import 'package:STTS/models/crop.dart';
import 'package:STTS/models/planting_returns.dart';
import 'package:json_annotation/json_annotation.dart';
part 'assigned_sub_grower.g.dart';

@JsonSerializable()
class AssignedInpection {
  @JsonKey(name: 'subgrower form')
  AssignedSubGrower? assignedSubGrower;
  @JsonKey(name: 'planting_return')
  PlantingReturns? plantingReturns;

  AssignedInpection({this.assignedSubGrower, this.plantingReturns});
  Map toJson() {
    return _$AssignedInpectionToJson(this);
  }

  factory AssignedInpection.fromJson(Map<String, dynamic> json) {
    return _$AssignedInpectionFromJson(json);
  }
}

@JsonSerializable()
class AssignedSubGrower {
  int? id;
  String? name;
  @JsonKey(name: 'gps_latitude')
  String? gpsLatitude;
  @JsonKey(name: 'gps_longitude')
  String? gpsLongitude;
  @JsonKey(name: 'planting_date')
  String? plantingdate;
  String? status;
  String? variety;
  String? size;
  @JsonKey(name: 'crop_obj')
  Crop? crop;

  AssignedSubGrower({
    this.id,
    this.name,
    this.gpsLatitude,
    this.gpsLongitude,
    this.status,
    this.variety,
    this.size,
    this.plantingdate,
    this.crop,
    // this.cropOBJ
  });
  Map toJson() {
    return _$AssignedSubGrowerToJson(this);
  }

  factory AssignedSubGrower.fromJson(Map<String, dynamic> json) {
    return _$AssignedSubGrowerFromJson(json);
  }
}
