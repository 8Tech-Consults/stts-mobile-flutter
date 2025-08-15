import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class CropsModel {
  static String end_point = "crops-list";
  int id = 0;
  String name = "";

  static Future<List<CropsModel>> get_items() async {
    List<DynamicTable> items = [];
    List<CropsModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          CropsModel item = new CropsModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.name = map['name'].toString();

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }
}
