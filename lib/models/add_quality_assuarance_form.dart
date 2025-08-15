import 'package:STTS/models/crop_variety.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add_quality_assuarance_form.g.dart';

@JsonSerializable()
class AddQualityAssuranceForm {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  String? type;
  String? name;
  String? address;
  String? telephone;
  @JsonKey(name: 'store_location')
  String? storeLocation;
  @JsonKey(name: 'quantiry_of_seed')
  String? quantiryOfSeed;
  @JsonKey(name: 'name_address_of_origin')
  String? nameAddressOfOrigin;
  @JsonKey(name: 'supplier_name')
  String? supplierName;
  @JsonKey(name: 'supplier_address')
  String? supplierAddress;
  @JsonKey(name: 'ista_certificate')
  String? istaCertificate;
  @JsonKey(name: 'inspector_id')
  int? inspectorId;
  @JsonKey(name: 'national_seed_board_reg_num')
  String? nationalSeedBoardRegNum;
  @JsonKey(name: 'is_import')
  bool? isImport;
  @JsonKey(name: 'permit_number')
  String? permitNumber;
  String? status;
  @JsonKey(name: 'status_comment')
  String? statusComment;
  @JsonKey(name: 'valid_from')
  String? validFrom;
  @JsonKey(name: 'valid_until')
  String? validUntil;
  @JsonKey(name: 'additional_conditions')
  String? additionalConditions;
  @JsonKey(name: 'import_export_permits_has_crops')
  List<Map<String, dynamic>>? cropVarieties;

  AddQualityAssuranceForm({
    this.type,
    this.name,
    this.administratorId,
    this.address,
    this.telephone,
    this.nameAddressOfOrigin,
    this.supplierName,
    this.supplierAddress,
    this.storeLocation,
    this.quantiryOfSeed,
    this.istaCertificate,
    this.inspectorId,
    this.nationalSeedBoardRegNum,
    this.isImport,
    this.permitNumber,
    this.status,
    this.statusComment,
    this.validFrom,
    this.validUntil,
    this.additionalConditions,
    this.cropVarieties,
  });
  Map toJson() {
    return _$AddQualityAssuranceFormToJson(this);
  }

  factory AddQualityAssuranceForm.fromJson(Map<String, dynamic> json) {
    return _$AddQualityAssuranceFormFromJson(json);
  }
}
