import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class PreOrderModel {
  static String end_point = "pre-orders/list";
  int id = 0;
  int administrator_id = 0;
  String created_at	= "";
  String updated_at	= "";
  String crop_variety_id = "";
  String quantity ="";
  String seed_class = "";
  String invetory_status = "";
  String collection_date = "";
  String crop_variety_text = "";
  String pickup_location = "";
  String detail = "";
  String status = "";
  static Future<List<PreOrderModel>> get_items() async {
    List<DynamicTable> items = [];
    List<PreOrderModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          PreOrderModel item = new PreOrderModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.updated_at =
                map['updated_at'].toString();
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.quantity = map['quantity'].toString();
            item.seed_class = map['seed_class'].toString();
            item.invetory_status = map['invetory_status'].toString();
            item.collection_date = map['collection_date'].toString();
            item.pickup_location = map['pickup_location'].toString();
            item.crop_variety_text = map['crop_variety_text'].toString();
            item.detail = map['detail'].toString();
            item.status = map['status'].toString();

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
      'title': "${this.crop_variety_id}'s Pre-Order",
      'data': [
        KeyValue('Order ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Crop Variety', Utils.string_parse(this.crop_variety_text, "-")),
        KeyValue('Seed Class', Utils.string_parse(this.seed_class, "-")),
        KeyValue('Quantity', Utils.string_parse(this.quantity, " - ")+"Metric tonnes"),
        KeyValue('Inventory Status', Utils.string_parse(this.invetory_status, "-")),
        KeyValue('Collection Date', Utils.string_parse(this.collection_date, "-")),
        KeyValue('Pickup Location', Utils.string_parse("#${this.pickup_location}", "-")),
        KeyValue('Status', Utils.string_parse("${this.status}", "-")),
        KeyValue('Details', Utils.string_parse("${this.detail}", "-")),
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
