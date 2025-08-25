import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'form.g.dart';

@JsonSerializable()
class Form {
  int? id;
  String? status;
  String? stage;
  @JsonKey(name: 'crop_variety')
  CropVariety? cropVariety;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  @JsonKey(name: 'size_of_field')
  String? sizeOfField;
  @JsonKey(name: 'size_of_field')
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
  @JsonKey(name: 'proposed_distance')
  String? proposedDistance;
  @JsonKey(name: 'general_conditions_of_crop')
  String? generalConditionsOfCrop;
  @JsonKey(name: 'estimated_yield')
  String? plantCount;
  @JsonKey(name: 'plant_count')
  String? estimatedYield;
  @JsonKey(name: 'further_remaks')
  String? furtherRemaks;
  @JsonKey(name: 'min_date')
  String? minDate;
  @JsonKey(name: 'sr10_number')
  String? sr10Number;
  @JsonKey(name: 'qds_declaration_id')
  String? qdsDeclarationId;

  Form({
    this.id,
    this.status,
    this.seedClass,
    this.cropVariety,
    this.sizeOfField,
    this.offTypes,
    this.diseases,
    this.noxiousWeeds,
    this.otherFeatures,
    this.otherWeeds,
    this.femaleReceptive,
    this.isolationDistance,
    this.proposedDistance,
    this.generalConditionsOfCrop,
    this.plantCount,
    this.estimatedYield,
    this.furtherRemaks,
    this.minDate,
    this.sr10Number,
    this.stage,
    this.qdsDeclarationId,
  });
  Map toJson() {
    return _$FormToJson(this);
  }

  factory Form.fromJson(Map<String, dynamic> json) {
    return _$FormFromJson(json);
  }
}
