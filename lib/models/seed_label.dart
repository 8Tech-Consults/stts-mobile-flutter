import 'package:json_annotation/json_annotation.dart';
part 'seed_label.g.dart';

@JsonSerializable()
class SeedLabel {
  int? id;
  @JsonKey(name: 'applicant_remarks')
  String? applicantRemarks;
  String? quantity;
  @JsonKey(name: 'available_stock')
  String? availableStock;
  @JsonKey(name: 'crop_variety_text')
  String? cropVarietyText;
  String? status;
  @JsonKey(name: 'created_at')
  String? createdAt;

  SeedLabel({
    this.id,
    this.applicantRemarks,
    this.quantity,
    this.cropVarietyText,
    this.status,
    this.availableStock,
    this.createdAt,
  });
  Map toJson() {
    return _$SeedLabelToJson(this);
  }

  factory SeedLabel.fromJson(Map<String, dynamic> json) {
    return _$SeedLabelFromJson(json);
  }
}
