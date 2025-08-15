import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class OrderModel {
  static String end_point = "orders/list";
  int id = 0;
  int administrator_id = 0;
  String created_at	= "";
  String updated_at	= "";
  String order_by = "";
  String crop_variety_id = "";
  String crop_variety_text = "";
  String product_id = "";
  String quantity = "";
  String detail = "";
  String payment_type = "";
  String receipt = "";
  String status = "";
  String total_price = "";

  static Future<List<OrderModel>> get_items() async {
    List<DynamicTable> items = [];
    List<OrderModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          OrderModel item = new OrderModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.updated_at =
                map['updated_at'].toString();
            item.order_by = map['order_by'].toString();
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.product_id = map['product_id'].toString();
            item.quantity = map['quantity'].toString();
            item.payment_type = map['payment_type'].toString();
            item.receipt = map['receipt'].toString();
            item.detail = map['detail'].toString();
            item.crop_variety_text = map['crop_variety_text'].toString();
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
      'title': "${this.product_id} Product Order",
      'data': [
        KeyValue('Order ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Product', Utils.string_parse(this.product_id, "-")),
        KeyValue('Crop Variety', Utils.string_parse(this.crop_variety_text, "-")),
        KeyValue('Quantity', Utils.string_parse(this.quantity, "-")),
        KeyValue('Payment mode', Utils.string_parse(this.payment_type, "-")),
        KeyValue('Receipt', Utils.string_parse(this.receipt, "-")),
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
