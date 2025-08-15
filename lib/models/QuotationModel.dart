import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class QuotationModel {
  static String end_point = "quotations/list/";
  int id = 0;
  int administrator_id = 0;
  String created_at = "";
  String updated_at = "";
  String crop_variety_id = "";
  String quantity = "";
  String supply_date ="";
  String pre_order_id = "";
  String seed_class = "";
  String invetory_status = "";
  String detail = "";
  String quotation_by = "";
  String status = "";
  String decline_reason = "";
  String price = "";
  static Future<List<QuotationModel>> get_items() async {
    List<DynamicTable> items = [];
    List<QuotationModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          QuotationModel item = new QuotationModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.updated_at =
                map['updated_at'].toString();
            item.quantity = map['quantity'].toString();
            item.supply_date = map['supply_date'].toString();
            item.status = map['status'].toString();
            item.pre_order_id = map['pre_order_id'].toString();
            item.seed_class = map['seed_class'].toString();
            item.invetory_status = map['invetory_status'].toString();
            item.price = map['price'].toString();
            item.detail = map['detail'].toString();
            item.quotation_by = map['quotation_by'].toString();
            item.decline_reason = map['decline_reason'].toString();

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
      'title': "${this.quotation_by}'s Quotation",
      'data': [
        KeyValue('Quotation ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Order ID', Utils.string_parse(this.pre_order_id, "-")),
        KeyValue('Crop Variety', Utils.string_parse(this.crop_variety_id, "-")),
        KeyValue('Seed Class', Utils.string_parse(this.seed_class, "-")),
        KeyValue('Quantity', Utils.string_parse(this.quantity, "-")),
        KeyValue('Price', Utils.string_parse("UGX: ${this.price}", "-")),
        KeyValue('Supply Date', Utils.string_parse(this.supply_date, "-")),
        KeyValue('Inventory Status', Utils.string_parse(this.invetory_status, "-")),
        KeyValue('Quoted by', Utils.string_parse("#${this.quotation_by}", "-")),
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
