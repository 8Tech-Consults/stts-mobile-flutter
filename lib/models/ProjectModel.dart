import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class ProjectModel {
  static String end_point = "projects";
  int id = 0;
  int head_of_project = 0;
  int department_id = 0;
  int enterprise_id = 0;
  String name = "";
  String short_name = "";

  static Future<List<ProjectModel>> get_items() async {
    List<DynamicTable> items = [];
    List<ProjectModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          ProjectModel item = new ProjectModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.head_of_project =
                Utils.int_parse(map['head_of_project'].toString());
            item.department_id =
                Utils.int_parse(map['department_id'].toString());
            item.enterprise_id =
                Utils.int_parse(map['enterprise_id'].toString());

            item.name = map['name'].toString();
            item.short_name = map['short_name'].toString();

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
