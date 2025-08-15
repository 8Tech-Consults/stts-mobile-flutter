import 'dart:convert';

import 'DynamicTable.dart';

class LoggedInUserModel {
  static String end_point = "logged_in_user";
  int id = 0;
  String name = "";
  String token = "";
  String remember_token = "";
  String created_at = "";
  String first_name = "";
  String last_name = "";
  String email = "";
  String avatar = "";



  static delete_all_items() async {
    List<DynamicTable> items =
        await DynamicTable.get_local_items(endpoint: end_point);
    int y = 0;
    for (y = 0; y < items.length; y++) {
      await items[y].delete();
    }
    List<DynamicTable> token_items =
        await DynamicTable.get_local_items(endpoint: 'token');

    for (y = 0; y < token_items.length; y++) {
      await token_items[y].delete();
    }

    return;
  }

  static Future<LoggedInUserModel> get_logged_in_user() async {
    LoggedInUserModel item = new LoggedInUserModel();
    DynamicTable _item = new DynamicTable();
    List<DynamicTable> items =
        await DynamicTable.get_local_items(endpoint: end_point);
    if (items.isEmpty) {
      return item;
    }

    _item = items[0];
    if (_item.data != null) {
      if (_item.data.length > 5) {
        Map<dynamic, dynamic> d = jsonDecode(_item.data);
        if (d['id'] != null) {
          item.name = d['name'].toString();
          item.id = d['id'];

          item.remember_token = d['remember_token'].toString();
          item.first_name = d['first_name'].toString();
          item.created_at = d['created_at'].toString();
          item.last_name = d['last_name'].toString();
          item.email = d['email'].toString();
          item.avatar = d['avatar'].toString();
        }
      }
    }

    return item;
  }

  static jsonStringToMap(String data) {
    List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }

  static login_user(dynamic raw, ) async {


    DynamicTable d = new DynamicTable();
    d.id = 1;
    d.own_id = 1;
    d.data_type = end_point;

    d.data = json.encode(raw);



    await DynamicTable.save_to_local_db(
        end_point: end_point, clear_previous: true, new_ids: [1], items: [d]);
  }

  static Future<String> get_token() async {
    List<DynamicTable> token_items =
        await DynamicTable.get_local_items(endpoint: 'token');
    if (token_items.isEmpty) {
      return '';
    }

    return token_items[0].data;
  }

  static save_token(String token) async {
    DynamicTable _token = new DynamicTable();
    _token.id = 1;
    _token.own_id = 1;
    _token.data_type = 'token';
    _token.data = token;

    await DynamicTable.save_to_local_db(
        end_point: 'token',
        clear_previous: true,
        new_ids: [1],
        items: [_token]);
  }
}
