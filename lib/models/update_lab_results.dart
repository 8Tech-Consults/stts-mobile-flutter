import 'package:json_annotation/json_annotation.dart';
part 'update_lab_results.g.dart';

@JsonSerializable()
class UpdateLabResults {
  int? purity;
  int? quantity;
  @JsonKey(name: 'germination_capacity')
  int? germinationCapacity;
  @JsonKey(name: 'abnormal_sprouts')
  int? abnormalSprouts;
  @JsonKey(name: 'broken_germss')
  int? brokenGerms;
  @JsonKey(name: 'report_recommendation')
  String? reportRecommendation;
  @JsonKey(name: 'receptionist_is_done')
  bool? receptionistIsDone;

  UpdateLabResults({
    this.purity,
    this.brokenGerms,
    this.quantity,
    this.germinationCapacity,
    this.abnormalSprouts,
    this.reportRecommendation,
    this.receptionistIsDone,
  });
  Map toJson() {
    return _$UpdateLabResultsToJson(this);
  }

  factory UpdateLabResults.fromJson(Map<String, dynamic> json) {
    return _$UpdateLabResultsFromJson(json);
  }
}
