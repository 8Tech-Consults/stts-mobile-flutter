import 'package:json_annotation/json_annotation.dart';
part 'add_sample_analysis.g.dart';

@JsonSerializable()
class AddSampleAnalysis {
  @JsonKey(name: 'sample_weight')
  int? sampleWeight;
  @JsonKey(name: 'packaging')
  String? packaging;
  @JsonKey(name: 'mother_lot')
  String? motherLot;
  @JsonKey(name: 'sample_condition')
  String? sampleCondition;
  @JsonKey(name: 'tests_required')
  String? testsRequired;
  int? status;
  @JsonKey(name: 'report_recommendation')
  int? reportRecommendation;

  AddSampleAnalysis({
    this.sampleWeight,
    this.packaging,
    this.motherLot,
    this.sampleCondition,
    this.testsRequired,
    this.status,
    this.reportRecommendation,
  });
  Map toJson() {
    return _$AddSampleAnalysisToJson(this);
  }

  factory AddSampleAnalysis.fromJson(Map<String, dynamic> json) {
    return _$AddSampleAnalysisFromJson(json);
  }
}
