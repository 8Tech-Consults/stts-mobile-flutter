import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class PlantingReturnModel {
  static String end_point = "planting-returns-grower/list";
  int id = 0;
  int administrator_id = 0;
  String	name ="";
  String size ="";
  String crop 	="";
  String variety ="";
  String district="" ;
  String subcourty="";
  String planting_date ="";
  String quantity_planted="";
  String expected_yield ="";
  String phone_number="";
  String gps_latitude ="";
  String gps_longitude ="";
  String detail ="";
  String status ="";
  String inspector="";
  String status_comment="";
  String field_name ="";
  String village ="";
  String seed_class ="";
  String estimated_yield ="";
  String further_remarks ="";
  String general_condition_of_the_crop ="";
  String proposed_isolation ="";
  String isolation_time="";
  String proposed_distance="";
  String isolation_distance="";
  String cultivar_characteristics_noxious_weeds="";
  String cultivar_characteristics_features ="";
  String cultivar_characteristics_disease ="";
  String cultivar_characteristics_types ="";
  String size_of_field ="";
  String crop_cultivar ="";


  static Future<List<PlantingReturnModel>> get_items() async {
    List<DynamicTable> items = [];
    List<PlantingReturnModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          PlantingReturnModel item = new PlantingReturnModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.name = map['name'].toString();
            item.size = map['size'].toString();
            item.crop = map['crop'].toString();
            item.variety = map['variety'].toString();
            item.district = map['district'].toString();
            item.subcourty = map['subcourty'].toString();
            item.planting_date = map['planting_date'].toString();
            item.quantity_planted = map['quantity_planted'].toString();
            item.expected_yield = map['expected_yield'].toString();
            item.phone_number = map['phone_number'].toString();
            item.gps_latitude = map['gps_latitude'].toString();
            item.gps_longitude =
                map['gps_longitude'].toString();
            item.detail =
                map['detail'].toString();
            item.status =
                map['status'].toString();
            item.inspector =
                map['inspector'].toString();
            item.status_comment = map['status_comment'].toString();
            item.field_name =
                map['field_name'].toString();
            item.village =
                map['village'].toString();
            item.seed_class = map['seed_class'].toString();
            item.estimated_yield = map['estimated_yield'].toString();
            item.further_remarks = map['further_remarks'].toString();
            item.general_condition_of_the_crop = map['general_condition_of_the_crop'].toString();
            item.proposed_isolation = map['proposed_isolation'].toString();
            item.isolation_time = map['isolation_time'].toString();
            item.proposed_distance = map['proposed_distance'].toString();
            item.isolation_distance = map['isolation_distance'].toString();
            item.cultivar_characteristics_noxious_weeds = map['cultivar_characteristics_noxious_weeds'].toString();
            item.cultivar_characteristics_features = map['cultivar_characteristics_features'].toString();
            item.cultivar_characteristics_types = map['cultivar_characteristics_types'].toString();
            item.size_of_field = map['size_of_field'].toString();
            item.crop_cultivar = map['crop_cultivar'].toString();

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
      'title': "${this.name} Seed Lab",
      'data': [
        KeyValue('Planting Return ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Applicant', Utils.string_parse(this.name, "-")),
        KeyValue('Field Name', Utils.string_parse(this.field_name, "-")),
        KeyValue('Size', Utils.string_parse(this.size, "-")),
        KeyValue('Crop', Utils.string_parse(this.crop, "-")),
        KeyValue('Variety', Utils.string_parse(this.variety, "-")),
        KeyValue('District', Utils.string_parse(this.district, "-")),
        KeyValue('Sub-County', Utils.string_parse(this.subcourty, "-")),
        KeyValue('Village', Utils.string_parse(this.village, "-")),
        KeyValue('Planting Date', Utils.string_parse("#${this.planting_date}", "-")),
        KeyValue('Quantity Planted', Utils.string_parse("${this.quantity_planted}", "-")),
        KeyValue('Expected Yield', Utils.string_parse("${this.expected_yield}", "-")),
        KeyValue('Phone number', Utils.string_parse("${this.phone_number}", "-")),
        KeyValue('Details', Utils.string_parse("${this.detail}", "-")),
        KeyValue('Status', Utils.string_parse("${this.status}", "-")),
        KeyValue('Status Comment', Utils.string_parse("${this.status_comment}", "-")),
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
