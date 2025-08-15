// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      seller: json['seller'] as String?,
      productItem: ProductItem.fromJson(json['form'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'seller': instance.seller,
      'form': instance.productItem,
    };

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      labTestNumber: json['lab_test_number'] as String?,
      price: json['price'] as String?,
      phone: json['phone'] as String?,
      cropVariety: json['crop_variety'] == null
          ? null
          : CropVariety.fromJson(json['crop_variety'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
      availableStock: json['available_stock'] as String?,
      administratorId: json['administrator_id'] as String?,
      seedClass: json['seed_class'] as String?,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'lab_test_number': instance.labTestNumber,
      'price': instance.price,
      'phone': instance.phone,
      'crop_variety': instance.cropVariety,
      'available_stock': instance.availableStock,
      'administrator_id': instance.administratorId,
      'quantity': instance.quantity,
      'seed_class': instance.seedClass,
    };
