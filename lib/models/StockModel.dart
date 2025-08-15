import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class StockModel {
  static String end_point = "form-stock-records/list";
  int id = 0;
  int administrator_id = 0;
  String created_at	= "";
  String updated_at	= "";
  String crop_variety_id = "";
  String seed_class= "";
  String source = "";
  String detail = "";
  String quantity = "";
  String is_deposit = "";
  String is_transfer = "";
  String lot_number ="";
  static Future<List<StockModel>> get_items() async {
    List<DynamicTable> items = [];
    List<StockModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          StockModel item = new StockModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.updated_at = map['updated_at'].toString();
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.lot_number = map['lot_number'].toString();
            item.quantity = map['quantity'].toString();
            item.seed_class = map['seed_class'].toString();
            item.source = map['source'].toString();
            item.is_deposit = map['is_deposit'].toString();
            item.is_transfer = map['is_transfer'].toString();
            item.detail = map['detail'].toString();

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
      'title': "${this.lot_number}",
      'data': [
        KeyValue('Order ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Crop Variety', Utils.string_parse(this.crop_variety_id, "-")),
        KeyValue('Lot Number', Utils.string_parse(this.lot_number, "-")),
        KeyValue('Seed Class', Utils.string_parse(this.seed_class, "-")),
        KeyValue('Quantity', Utils.string_parse("${this.quantity} M.Tonnes", "-")),
        KeyValue('Source', Utils.string_parse(this.source, "-")),
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
