import 'package:json_annotation/json_annotation.dart';
part 'add_seed_label.g.dart';

@JsonSerializable()
class AddSeedLabel {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  @JsonKey(name: 'seed_lab_id')
  int? seedLabId;
  @JsonKey(name: 'seed_label_package_id')
  int? seedLabelPackageId;
  @JsonKey(name: 'available_stock')
  int? availableStock;
  String? receipt;
  @JsonKey(name: 'applicant_remarks')
  String? applicantRemarks;
  String? image;
  int? quantity;
  int? status;
  @JsonKey(name: 'status_comment')
  String? statusComment;

  AddSeedLabel({
    this.administratorId,
    this.seedLabId,
    this.seedLabelPackageId,
    this.availableStock,
    this.receipt,
    this.applicantRemarks,
    this.image,
    this.quantity,
    this.status,
    this.statusComment,
  });
  Map toJson() {
    return _$AddSeedLabelToJson(this);
  }

  factory AddSeedLabel.fromJson(Map<String, dynamic> json) {
    return _$AddSeedLabelFromJson(json);
  }
}
