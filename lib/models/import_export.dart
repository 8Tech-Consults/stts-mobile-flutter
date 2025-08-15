import 'package:json_annotation/json_annotation.dart';
part 'import_export.g.dart';

@JsonSerializable()
class ImportExport {
  int? id;
  String? name;
  String? category;
  String? telephone;
  String? status;
  @JsonKey(name: 'quantiry_of_seed')
  String? quantiryOfSeed;
  @JsonKey(name: 'created_at')
  String? createdAt;

  ImportExport({
    this.id,
    this.name,
    this.category,
    this.telephone,
    this.status,
    this.quantiryOfSeed,
    this.createdAt,
  });
  Map toJson() {
    return _$ImportExportToJson(this);
  }

  factory ImportExport.fromJson(Map<String, dynamic> json) {
    return _$ImportExportFromJson(json);
  }
}
