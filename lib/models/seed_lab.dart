import 'package:json_annotation/json_annotation.dart';
part 'seed_lab.g.dart';

@JsonSerializable()
class SeedLab {
  int? id;
  @JsonKey(name: 'collection_date')
  String? collectionDate;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'applicant_remarks')
  String? applicantRemarks;
  String? quantity;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  @JsonKey(name: 'crop_variety_text')
  String? cropVarietyText;
  @JsonKey(name: 'tests_required')
  String? testsRequired;
  String? status;

  SeedLab({
    this.id,
    this.collectionDate,
    this.applicantRemarks,
    this.quantity,
    this.lotNumber,
    this.cropVarietyText,
    this.testsRequired,
    this.createdAt,
    this.status,
  });
  Map toJson() {
    return _$SeedLabToJson(this);
  }

  factory SeedLab.fromJson(Map<String, dynamic> json) {
    return _$SeedLabFromJson(json);
  }
}
