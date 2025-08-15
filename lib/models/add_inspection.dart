import 'package:json_annotation/json_annotation.dart';
part 'add_inspection.g.dart';

@JsonSerializable()
class AddInspection {
  int? status;
  int? stage;
  @JsonKey(name: 'status_comment')
  String? statusComment;
  // @JsonKey(name: 'crop_variety_id')
  // int? cropVarietyId;
  // @JsonKey(name: 'qds_declaration_id')
  // int? qdsDeclarationId;
  @JsonKey(name: 'sr10_number')
  String? sr10Number;
  @JsonKey(name: 'planting_return_crop_name')
  String? plantingReturnCropName;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  @JsonKey(name: 'size_of_field')
  String? sizeOfField;
  @JsonKey(name: 'off_types')
  String? offTypes;
  String? diseases;
  @JsonKey(name: 'noxious_weeds')
  String? noxiousWeeds;
  @JsonKey(name: 'other_features')
  String? otherFeatures;
  @JsonKey(name: 'other_weeds')
  String? otherWeeds;
  @JsonKey(name: 'female_receptive')
  bool? femaleReceptive;
  @JsonKey(name: 'isolation_distance')
  String? isolationDistance;
  String? variety;
  @JsonKey(name: 'proposed_distance')
  String? proposedDistance;
  @JsonKey(name: 'general_conditions_of_crop')
  String? generalConditionsOfCrop;
  @JsonKey(name: 'estimated_yield')
  String? estimatedYield;
  @JsonKey(name: 'further_remaks')
  String? furtherRemaks;
  // @JsonKey(name: 'is_done')
  // String? isDone;

  AddInspection({
    this.status,
    this.stage,
    this.statusComment,
    // this.cropVarietyId,
    this.sr10Number,
    this.plantingReturnCropName,
    this.seedClass,
    this.sizeOfField,
    this.offTypes,
    this.diseases,
    this.noxiousWeeds,
    this.otherFeatures,
    this.otherWeeds,
    this.femaleReceptive,
    this.isolationDistance,
    this.variety,
    this.proposedDistance,
    this.generalConditionsOfCrop,
    this.estimatedYield,
    this.furtherRemaks,
    // this.isDone,
    // this.qdsDeclarationId,
  });
  Map toJson() {
    return _$AddInspectionToJson(this);
  }

  factory AddInspection.fromJson(Map<String, dynamic> json) {
    return _$AddInspectionFromJson(json);
  }
}
