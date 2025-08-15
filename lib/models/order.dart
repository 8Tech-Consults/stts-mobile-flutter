import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  @JsonKey(name: 'product_id')
  String? productId;
  String? quantity;
  @JsonKey(name: 'crop_variety')
  CropVariety? cropVariety;
  @JsonKey(name: 'crop_variety_text')
  String? cropVarietyText;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  @JsonKey(name: 'pickup_location')
  String? pickupLocation;
  String? status;

  Order({
    this.id,
    this.productId,
    this.quantity,
    this.cropVarietyText,
    this.status,
    this.cropVariety,
    this.seedClass,
    this.pickupLocation,
  });
  Map toJson() {
    return _$OrderToJson(this);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return _$OrderFromJson(json);
  }
}
