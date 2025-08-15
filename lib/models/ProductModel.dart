import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class ProductModel {
  static String end_point = "products/list";
  int id = 0;
  String created_at = "";
  String administrator_id = "";
  String crop_variety_id = "";
  String seed_label_id = "";
  String quantity = "";
  String lab_test_number = "";
  String lot_number = "";
  String seed_class = "";
  String price = "";
  String wholesale_price = "";
  String image = "";
  String images = "";
  String source = "";
  String detail = "";
  String name = "";
  String phone = "";
  String total_price = "";

  static Future<List<ProductModel>> get_items() async {
    List<DynamicTable> items = [];
    List<ProductModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          ProductModel item = new ProductModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.created_at =
                Utils.string_parse(map['created_at'].toString(), "-");
            item.administrator_id =
                Utils.string_parse(map['administrator_id'].toString(), "1");
            item.crop_variety_id =
                Utils.string_parse(map['crop_variety_id'].toString(), "1");
            item.seed_label_id =
                Utils.string_parse(map['seed_label_id'].toString(), "1");
            item.quantity = Utils.string_parse(map['quantity'].toString(), "1");
            item.lab_test_number =
                Utils.string_parse(map['lab_test_number'].toString(), "1");
            item.lot_number =
                Utils.string_parse(map['lot_number'].toString(), "1");
            item.seed_class =
                Utils.string_parse(map['seed_class'].toString(), "-");
            item.price = Utils.string_parse(map['price'].toString(), "-");
            item.wholesale_price =
                Utils.string_parse(map['wholesale_price'].toString(), "-");
            item.image = Utils.string_parse(map['image'].toString(), "");
            item.images = Utils.string_parse(map['images'].toString(), "[]");
            item.source = Utils.string_parse(map['source'].toString(), "1");
            item.detail = Utils.string_parse(map['detail'].toString(), "");
            item.name = Utils.string_parse(map['name'].toString(), "");
            item.phone = Utils.string_parse(map['phone'].toString(), "");
            item.total_price =
                Utils.string_parse(map['total_price'].toString(), "");

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }

  String get_image() {
    return 'https://images.unsplash.com/photo-1570042707108-66761758315a?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770';
  }
}
