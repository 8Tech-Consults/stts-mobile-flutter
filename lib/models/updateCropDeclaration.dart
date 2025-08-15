import 'package:json_annotation/json_annotation.dart';
part 'updateCropDeclaration.g.dart';

@JsonSerializable()
class UpdateCropDeclaration {
  int status;

  UpdateCropDeclaration({
    required this.status,
  });
  Map toJson() {
    return _$UpdateCropDeclarationToJson(this);
  }

  factory UpdateCropDeclaration.fromJson(Map<String, dynamic> json) {
    return _$UpdateCropDeclarationFromJson(json);
  }
}
