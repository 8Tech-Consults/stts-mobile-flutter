import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class SeedLabelPackageModel {
  static String end_point = "seed-labels-packages/list";

  int id = 0;
  String crop_variety_id = '';
  String crop_variety_text = '';
  String package_price = '';
  String package_size = '';

  static Future<List<SeedLabelPackageModel>> get_items() async {
    List<DynamicTable> items = [];
    List<SeedLabelPackageModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});
    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          SeedLabelPackageModel item = new SeedLabelPackageModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {

            item.crop_variety_text = map['crop_variety_text'].toString();
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.package_price = map['package_price'].toString();
            item.package_size = map['package_size'].toString();

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
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
