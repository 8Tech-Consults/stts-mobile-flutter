import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trace.g.dart';

@JsonSerializable()
class Trace {
  String? crop;
  @JsonKey(name: 'broken_germs')
  String? brokenGerms;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  @JsonKey(name: 'crop_variety')
  CropVariety? cropVariety;
  @JsonKey(name: 'collection_date')
  String? collectionDate;
  @JsonKey(name: 'lab_test_number')
  String? labTestNumber;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  @JsonKey(name: 'germination_capacity')
  String? germinationCapacity;
  @JsonKey(name: 'test_date')
  String? testDate;

  Trace({
    this.crop,
    this.brokenGerms,
    this.cropVariety,
    this.lotNumber,
    this.collectionDate,
    this.labTestNumber,
    this.seedClass,
    this.germinationCapacity,
    this.testDate,
  });
  Map toJson() {
    return _$TraceToJson(this);
  }

  factory Trace.fromJson(Map<String, dynamic> json) {
    return _$TraceFromJson(json);
  }
}
