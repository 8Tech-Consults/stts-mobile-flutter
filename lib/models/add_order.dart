import 'package:json_annotation/json_annotation.dart';
part 'add_order.g.dart';

@JsonSerializable()
class AddOrder {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  @JsonKey(name: 'order_by')
  int? orderBy;
  @JsonKey(name: 'crop_variety_id')
  int? cropVarietyId;
  @JsonKey(name: 'seed_class')
  String? seedClass;
  @JsonKey(name: 'product_id')
  int? productId;
  int? quantity;
  String? detail;
  @JsonKey(name: 'payment_type')
  String? paymentType;
  @JsonKey(name: 'total_price')
  int? totalPrice;
  int? status;

  AddOrder({
    this.administratorId,
    this.orderBy,
    this.cropVarietyId,
    this.seedClass,
    this.productId,
    this.quantity,
    this.detail,
    this.paymentType,
    this.totalPrice,
    this.status,
  });
  Map toJson() {
    return _$AddOrderToJson(this);
  }

  factory AddOrder.fromJson(Map<String, dynamic> json) {
    return _$AddOrderFromJson(json);
  }
}
