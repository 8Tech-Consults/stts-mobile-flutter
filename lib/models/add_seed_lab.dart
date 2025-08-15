import 'package:json_annotation/json_annotation.dart';
part 'add_seed_lab.g.dart';

@JsonSerializable()
class AddSeedLab {
  @JsonKey(name: 'administrator_id')
  int? administratorId;
  @JsonKey(name: 'crop_variety_id')
  int? cropVarietyId;
  @JsonKey(name: 'form_stock_examination_request_id')
  int? formStockExaminationRequestId;
  @JsonKey(name: 'collection_date')
  String? collectionDate;
  @JsonKey(name: 'payment_receipt')
  String? paymentReceipt;
  @JsonKey(name: 'applicant_remarks')
  String? applicantRemarks;

  AddSeedLab({
    this.administratorId,
    this.cropVarietyId,
    this.formStockExaminationRequestId,
    this.collectionDate,
    this.paymentReceipt,
    this.applicantRemarks,
  });
  Map toJson() {
    return _$AddSeedLabToJson(this);
  }

  factory AddSeedLab.fromJson(Map<String, dynamic> json) {
    return _$AddSeedLabFromJson(json);
  }
}
