import 'package:json_annotation/json_annotation.dart';
part 'update_planting_return.g.dart';

@JsonSerializable()
class UpdatePlantingReturn {
  String? status;

  UpdatePlantingReturn({
    this.status,
  });
  Map toJson() {
    return _$UpdatePlantingReturnToJson(this);
  }

  factory UpdatePlantingReturn.fromJson(Map<String, dynamic> json) {
    return _$UpdatePlantingReturnFromJson(json);
  }
}
