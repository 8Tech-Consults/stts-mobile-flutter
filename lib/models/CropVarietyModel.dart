import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class CropVarietyModel {

  static String end_point = "crop-varieties-list";
  int id = 0;
  int crop_id = 0;
  String name = "";

  static Future<List<CropVarietyModel>> get_items() async {
    List<DynamicTable> items = [];
    List<CropVarietyModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          CropVarietyModel item = new CropVarietyModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {

            item.crop_id =
                Utils.int_parse(map['crop_id'].toString());

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
