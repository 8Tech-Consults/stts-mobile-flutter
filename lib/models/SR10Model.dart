import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class SR10Model {
  static String end_point = "form-sr10/list";
  int id = 0;
  int administrator_id = 0;
  int planting_return_id = 0;
  String stage = "";
  String status = "";
  String status_comment = "";
  String submited_date = "";
  String min_date = "";
  String max_date = "";
  String is_active = "";
  String is_done = "";
  String is_initialized = "";
  String valid_from = "";
  String valid_until = "";
  String approve_by_farmer = "";
  String farmer_id = "";
  String planting_return_crop_name = "";
  String seed_class = "";
  String size_of_field = "";
  String off_types = "";
  String diseases = "";
  String noxious_weeds = "";
  String other_features = "";
  String other_weeds = "";
  String isolation_distance = "";
  String variety = "";
  String proposed_distance = "";
  String general_conditions_of_crop = "";
  String estimated_yield = "";
  String futher_remarks = "";
  String sr10_number = "";
  String is_final = "";

  static Future<List<SR10Model>> get_items() async {
    List<DynamicTable> items = [];
    List<SR10Model> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          SR10Model item = new SR10Model();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.planting_return_id =
                Utils.int_parse(map['planting_return_id'].toString());
            item.stage = map['stage'].toString();
            item.status = map['status'].toString();
            item.status_comment = map['status_comment'].toString();
            item.submited_date = map['submited_date'].toString();
            item.min_date = map['min_date'].toString();
            item.max_date = map['max_date'].toString();
            item.is_active = map['is_active'].toString();
            item.is_done = map['is_done'].toString();
            item.is_initialized = map['is_initialized'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.approve_by_farmer = map['approve_by_farmer'].toString();
            item.farmer_id = map['farmer_id'].toString();
            item.planting_return_crop_name =
                map['planting_return_crop_name'].toString();
            item.status_comment = map['status_comment'].toString();
            item.seed_class = map['seed_class'].toString();
            item.size_of_field = map['size_of_field'].toString();
            item.seed_class = map['seed_class'].toString();
            item.estimated_yield = map['estimated_yield'].toString();
            item.off_types = map['off_types'].toString();
            item.diseases = map['diseases'].toString();
            item.noxious_weeds = map['noxious_weeds'].toString();
            item.other_features = map['other_features'].toString();
            item.other_weeds = map['other_weeds'].toString();
            item.isolation_distance = map['isolation_distance'].toString();
            item.variety = map['variety'].toString();
            item.proposed_distance = map['proposed_distance'].toString();
            item.general_conditions_of_crop =
                map['general_conditions_of_crop'].toString();
            item.estimated_yield = map['estimated_yield'].toString();
            item.futher_remarks = map['futher_remarks'].toString();
            item.sr10_number = map['sr10_number'].toString();
            item.is_final = map['is_final'].toString();

            _items.add(item);
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }

  dynamic get_details() {
    return {
      'title': "Plant inspection",
      'data': [
        KeyValue('Inspection ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Scheduled inspection date',
            Utils.string_parse(this.min_date, "-")),
        KeyValue('Date inspected', Utils.string_parse(this.submited_date, "-")),
        KeyValue('Planting_return ID',
            Utils.string_parse("#${this.planting_return_id}", "-")),
        KeyValue('Inspection stage', Utils.string_parse("${this.stage}", "-")),
        KeyValue('Inspection Status',
            Utils.string_parse(Utils.tell_status(this.status), "-")),
        KeyValue(
            'Status comment', Utils.string_parse(this.status_comment, "-")),
        KeyValue('Crop to inspect',
            Utils.string_parse(this.planting_return_crop_name, "-")),
        KeyValue('Crop variety', Utils.string_parse(this.variety, "-")),
        KeyValue('Seed class', Utils.string_parse(this.seed_class, "-")),
        KeyValue('Size of field', Utils.string_parse(this.size_of_field, "-")),
        KeyValue('Off types', Utils.string_parse(this.off_types, "-")),
        KeyValue('Diseases', Utils.string_parse(this.diseases, "-")),
        KeyValue('Other features', Utils.string_parse(this.noxious_weeds, "-")),
        KeyValue('Other weeds', Utils.string_parse(this.other_weeds, "-")),
        KeyValue('Isolation distance',
            Utils.string_parse(this.isolation_distance, "-")),
        KeyValue('Proposed distance',
            Utils.string_parse(this.proposed_distance, "-")),
        KeyValue('General conditions of crop',
            Utils.string_parse(this.general_conditions_of_crop, "-")),
        KeyValue(
            'Estimated yield', Utils.string_parse(this.estimated_yield, "-")),
        KeyValue(
            'Futher remarks', Utils.string_parse(this.futher_remarks, "-")),
        KeyValue(
            'SR10 number', "#" + Utils.string_parse(this.sr10_number, "-")),
      ]
    };
  }
}
