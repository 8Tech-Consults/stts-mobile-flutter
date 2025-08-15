import 'package:json_annotation/json_annotation.dart';
part 'seed_stock.g.dart';

@JsonSerializable()
class SeedStock {
  String? user;
  @JsonKey(name: 'crop_variety')
  String? cropVariety;
  @JsonKey(name: 'id')
  SeedId? seedId;

  SeedStock({
    this.user,
    this.cropVariety,
    this.seedId,
  });
  Map toJson() {
    return _$SeedStockToJson(this);
  }

  factory SeedStock.fromJson(Map<String, dynamic> json) {
    return _$SeedStockFromJson(json);
  }
}

@JsonSerializable()
class SeedId {
  String? source;
  String? quantity;
  @JsonKey(name: 'lot_number')
  String? lotNumber;
  SeedId({
    this.source,
    this.quantity,
    this.lotNumber,
  });
  Map toJson() {
    return _$SeedIdToJson(this);
  }

  factory SeedId.fromJson(Map<String, dynamic> json) {
    return _$SeedIdFromJson(json);
  }
}
