import 'package:json_annotation/json_annotation.dart';
part 'Sr4Model.g.dart';

@JsonSerializable()
class SrModel {
  @JsonKey(name: 'name_of_applicant')
  String? nameOfApplicant;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'status_comment')
  String? statusComment;
  @JsonKey(name: 'seed_board_registration_number')
  String? seedBoardRegistrationNumber;
  String? status;
  String? type;
  @JsonKey(name: 'grower_number')
  String? growerNumber;

  SrModel({
    this.status,
    this.nameOfApplicant,
    this.type,
    this.createdAt,
    this.statusComment,
    this.seedBoardRegistrationNumber,
    this.growerNumber,
  });
  Map toJson() {
    return _$SrModelToJson(this);
  }

  factory SrModel.fromJson(Map<String, dynamic> json) {
    return _$SrModelFromJson(json);
  }
}
