import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class SeedLabelModel {
  static String end_point = "seed-labels/list";
  int id = 0;
  int administrator_id = 0;
  int seed_lab_id = 0;
  String crop_variety_id = "";
  String crop_variety_text = "";
  String seed_label_package_id = "";
  int quantity = 0;
  String applicant_remarks = "";
  String status = "";
  String status_comment = "";
  String receipt = "";
  String is_processed = "";
  int price = 0;
  String image = "";
  String images = "";
  String created_at ="";

  static Future<List<SeedLabelModel>> get_items() async {
    List<DynamicTable> items = [];
    List<SeedLabelModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          SeedLabelModel item = new SeedLabelModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.seed_lab_id = Utils.int_parse(map['seed_lab_id'].toString());
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.created_at = map['created_at'].toString();
            item.seed_label_package_id =
                map['seed_label_package_id'].toString();
            item.quantity = Utils.int_parse(map['quantity'].toString());
            item.applicant_remarks = map['applicant_remarks'].toString();
            item.status = map['status'].toString();
            item.status_comment = map['status_comment'].toString();
            item.receipt = map['receipt'].toString();
            item.is_processed = map['is_processed'].toString();
            item.price = Utils.int_parse(map['price'].toString());
            item.image = map['image'].toString();
            item.crop_variety_text = map['crop_variety_text'].toString();
            item.images = map['images'].toString();

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }


  dynamic get_details()  {
    return {
      'title': "Seed Label",
      'data': [
        KeyValue('Seed Label ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Seed Lab ID', Utils.string_parse(this.seed_lab_id, "-")),
        KeyValue(
            'Crop Variety', Utils.string_parse(this.crop_variety_text, "-")),
        KeyValue('Seed Label Package ID',
            Utils.string_parse(this.seed_label_package_id, "-")),
        KeyValue('Quantity', Utils.string_parse(this.quantity, "-")),
        KeyValue('Price', Utils.string_parse("UGX: ${this.price}", "-")),
        KeyValue('Applicant Remarks',
            Utils.string_parse("#${this.applicant_remarks}", "-")),
        KeyValue('Status', Utils.tell_status("${this.status}")),
        KeyValue('Remarks on status',
            Utils.string_parse("${this.status_comment}", "-")),
      ]
    };
  }

  static delete_all_items() async {
    List<DynamicTable> items =
    await DynamicTable.get_local_items(endpoint: end_point);
    int y = 0;
    for (y = 0; y < items.length; y++) {
      await items[y].delete();
    }
    return;
  }
}
