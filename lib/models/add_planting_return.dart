import 'package:json_annotation/json_annotation.dart';
part 'add_planting_return.g.dart';

@JsonSerializable()
class AddPlantingReturn {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  String? name;
  int? size;
  String? crop;
  String? variety;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  @JsonKey(name: 'source_of_seed')
  String? sourceOfSeed;
  @JsonKey(name: 'field_name')
  String? fieldName;
  String? district;
  String? subcounty;
  String? village;
  @JsonKey(name: 'planting_date')
  String? plantingDate;
  @JsonKey(name: 'quantity_planted')
  int? quantityPlanted;
  @JsonKey(name: 'expected_yield')
  int? expectedYield;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'gps_latitude')
  String? gpsLatitude;
  @JsonKey(name: 'gps_longitude')
  String? gpsLongitude;
  String? detail;
  String? status;

  AddPlantingReturn({
    this.detail,
    this.gpsLongitude,
    this.gpsLatitude,
    this.expectedYield,
    this.village,
    this.plantingDate,
    this.quantityPlanted,
    this.administratorId,
    this.name,
    this.size,
    this.crop,
    this.variety,
    this.seedClass,
    this.lotNumber,
    this.sourceOfSeed,
    this.fieldName,
    this.district,
    this.subcounty,
    this.phoneNumber,
    this.status,
  });
  Map toJson() {
    return _$AddPlantingReturnToJson(this);
  }

  factory AddPlantingReturn.fromJson(Map<String, dynamic> json) {
    return _$AddPlantingReturnFromJson(json);
  }
}
