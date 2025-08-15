import 'package:json_annotation/json_annotation.dart';
part 'add_stock_form.g.dart';

@JsonSerializable()
class AddStockForm {
  // @JsonKey(name: 'administrator_id')
  // int? administratorId;
  int? status;
  int? yield;

  AddStockForm({
    // this.administratorId,
    this.status,
    this.yield,
  });
  Map toJson() {
    return _$AddStockFormToJson(this);
  }

  factory AddStockForm.fromJson(Map<String, dynamic> json) {
    return _$AddStockFormFromJson(json);
  }
}
