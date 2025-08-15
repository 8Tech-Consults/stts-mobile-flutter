import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class NotificationModel {
  static String end_point = "notifications/list";
  int id = 0;
  int administrator_id = 0;
  String created_at	= "";
  String updated_at	= "";
  String title = "";
  String details= "";
  int seen = 0;

  static Future<List<NotificationModel>> get_items() async {
    List<DynamicTable> items = [];
    List<NotificationModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          NotificationModel item = new NotificationModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.updated_at = map['updated_at'].toString();
            item.title = map['title'].toString();
            item.details = map['lot_number'].toString();
            item.seen = Utils.int_parse(map['seen'].toString());

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
      'title': "${this.title}",
      'data': [
        KeyValue('Title', Utils.string_parse("${this.title}", "-")),
        KeyValue('Details', Utils.string_parse(this.details, "-")),
        KeyValue('Received At', Utils.string_parse(this.created_at, "-")),
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
