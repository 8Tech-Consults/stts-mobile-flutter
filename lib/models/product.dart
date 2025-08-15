import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  String? seller;
  @JsonKey(name: 'form')
  ProductItem productItem;

  Product({
    this.seller,
    required this.productItem,
  });
  Map toJson() {
    return _$ProductToJson(this);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
}

@JsonSerializable()
class ProductItem {
  int? id;
  String? name;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'lab_test_number')
  String? labTestNumber;
  String? price;
  String? phone;
  @JsonKey(name: 'crop_variety')
  CropVariety? cropVariety;
  @JsonKey(name: 'available_stock')
  String? availableStock;
  @JsonKey(name: 'administrator_id')
  String? administratorId;
  String? quantity;
  @JsonKey(name: 'seed_class')
  String? seedClass;

  ProductItem({
    this.id,
    this.name,
    this.imageUrl,
    this.labTestNumber,
    this.price,
    this.phone,
    this.cropVariety,
    this.quantity,
    this.availableStock,
    this.administratorId,
    this.seedClass,
  });
  Map toJson() {
    return _$ProductItemToJson(this);
  }

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return _$ProductItemFromJson(json);
  }
}
