import 'dart:convert';
import 'dart:ffi';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class CropDeclarationModel {
  static String end_point = "qds-crop-declarations/list";
  int id = 0;
  int administrator_id = 0;
  String form_qd_id = "";
  String created_at = "";
  String source_of_seed = "";
  String field_size = "";
  String seed_rate = "";
  String amount = "";
  String payment_receipt = "";
  String crop_varieties = "";
  String status = "";
  String inspector = "";
  String status_comment = "";
  String valid_from = "";
  String valid_until = "";

  static Future<List<CropDeclarationModel>> get_items() async {
    List<DynamicTable> items = [];
    List<CropDeclarationModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          CropDeclarationModel item = new CropDeclarationModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.form_qd_id = map['form_qd_id'].toString();
            item.source_of_seed = map['source_of_seed'].toString();
            item.field_size = map['field_size'].toString();
            item.seed_rate = map['seed_rate'].toString();
            item.amount = map['amount'].toString();
            item.created_at = map['created_at'].toString();
            item.payment_receipt = map['payment_receipt'].toString();
            item.status = map['status'].toString();
            item.inspector = map['inspector'].toString();
            item.status_comment = map['status_comment'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }

  dynamic get_details() {
    return {
      'title': "Crop declaration",
      'data': [

        KeyValue('QDS FORM ID', Utils.string_parse("#${this.form_qd_id}", "-")),
        KeyValue('Status', Utils.string_parse( Utils.tell_status(this.status) , "-")),
        KeyValue('Created', Utils.string_parse("${this.created_at}", "-")),
        KeyValue('Source of seed', Utils.string_parse("${this.source_of_seed}", "-")),
        KeyValue('Field size', Utils.string_parse("${this.field_size}", "-")),
        KeyValue('Seed rate', Utils.string_parse("${this.seed_rate}", "-")),
        KeyValue('Amount', Utils.string_parse("${this.amount}", "-")),
        KeyValue('Payment receipt', Utils.string_parse("${this.payment_receipt}", "-")),
        KeyValue('Crops', Utils.string_parse("${this.crop_varieties}", "-")),

      ]
    };
  }
}
