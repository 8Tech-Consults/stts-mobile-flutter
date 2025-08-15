import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'quotation.g.dart';

@JsonSerializable()
class Quotation {
  int? id;
  @JsonKey(name: 'supply_date')
  String? supplyDate;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  String? price;
  @JsonKey(name: 'crop_variety')
  CropVariety? cropVariety;
  String? status;
  String? quantity;

  Quotation({
    this.id,
    this.seedClass,
    this.supplyDate,
    this.price,
    this.cropVariety,
    this.quantity,
    this.status,
  });
  Map toJson() {
    return _$QuotationToJson(this);
  }

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return _$QuotationFromJson(json);
  }
}
