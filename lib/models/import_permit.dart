import 'package:json_annotation/json_annotation.dart';
part 'import_permit.g.dart';

@JsonSerializable()
class ImportPermit {
  String? name;
  String? address;
  @JsonKey(name: 'supplier_name')
  String? supplierName;

  ImportPermit({
    this.name,
    this.address,
    this.supplierName,
  });
  Map toJson() {
    return _$ImportPermitToJson(this);
  }

  factory ImportPermit.fromJson(Map<String, dynamic> json) {
    return _$ImportPermitFromJson(json);
  }
}
