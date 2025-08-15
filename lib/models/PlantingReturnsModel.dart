import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class PlantingReturnsModel {
  static String end_point = "crops-list";
  int id = 0;
  int administrator_id = 0;
  String name ="";
  String address="";
  String telephone ="";
  String seed_rate ="";
  String registerd_dealer ="";
  String longitude ="";
  String latitude ="";
  String status = "";
  String inspector ="";
  String status_comment = "";
  String previous_crops = "";
  String date_harvest = "";
  String date_planted = "";
  String size_of_land = "";
  String lot_number 	="";
  String crop_id 	= "";
  String amount_enclosed = "";
  String payment_receipt = "";
  String valid_from = "";
  String valid_until = "";
  String is_not_used = "";
  String sub_growers_file ="";


  static Future<List<PlantingReturnsModel>> get_items() async {
    List<DynamicTable> items = [];
    List<PlantingReturnsModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          PlantingReturnsModel item = new PlantingReturnsModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.name = map['name'].toString();
            item.address = map['address'].toString();
            item.telephone = map['telephone'].toString();
            item.seed_rate = map['seed_rate'].toString();
            item.registerd_dealer = map['registerd_dealer'].toString();
            item.longitude = map['longitude'].toString();
            item.latitude = map['latitude'].toString();
            item.status = map['status'].toString();
            item.inspector = map['inspector'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.status =
                map['status'].toString();
            item.inspector =
                map['inspector'].toString();
            item.status_comment =
                map['status_comment'].toString();
            item.previous_crops =
                map['previous_crops'].toString();
            item.date_harvest = map['date_harvest'].toString();
            item.size_of_land =
                map['size_of_land'].toString();
            item.lot_number =
                map['lot_number'].toString();
            item.crop_id = map['crop_id'].toString();
            item.amount_enclosed = map['amount_enclosed'].toString();
            item.payment_receipt = map['payment_receipt'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.is_not_used = map['is_not_used'].toString();
            item.sub_growers_file = map['sub_growers_file'].toString();

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }
}
