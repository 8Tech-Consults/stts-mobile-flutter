import 'package:json_annotation/json_annotation.dart';
part 'update_planting_return.g.dart';

@JsonSerializable()
class UpdatePlantingReturn {
  String? status;
  String? variety;

  UpdatePlantingReturn({this.status,this.variety});
  Map toJson() {
    return _$UpdatePlantingReturnToJson(this);
  }

  factory UpdatePlantingReturn.fromJson(Map<String, dynamic> json) {
    return _$UpdatePlantingReturnFromJson(json);
  }
}
