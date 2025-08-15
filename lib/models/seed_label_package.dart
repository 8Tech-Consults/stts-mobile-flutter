import 'package:json_annotation/json_annotation.dart';
part 'seed_label_package.g.dart';

@JsonSerializable()
class SeedLabelPackage {
  int? id;
  @JsonKey(name: 'package_size')
  String? packageSize;
  @JsonKey(name: 'package_price')
  String? packagePrice;

  SeedLabelPackage({
    this.id,
    this.packageSize,
    this.packagePrice,
  });
  Map toJson() {
    return _$SeedLabelPackageToJson(this);
  }

  factory SeedLabelPackage.fromJson(Map<String, dynamic> json) {
    return _$SeedLabelPackageFromJson(json);
  }
}
