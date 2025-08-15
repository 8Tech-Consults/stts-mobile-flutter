import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class FormSr6Model {
  static String end_point = "form-sr6/list";
  int id = 0;
  int administrator_id = 0;
  String created_at = "";
  String name_of_applicant = "";
  String address = "";
  String company_initials = "";
  String premises_location = "";
  String years_of_expirience = "";
  String dealers_in = "";
  String previous_grower_number = "";
  String cropping_histroy = "";
  String have_adequate_isolation = "";
  String aware_of_minimum_standards = "";
  String have_adequate_labor = "";
  String signature_of_applicant = "";
  String grower_number = "";
  String registration_number = "";
  String valid_from = "";
  String valid_until = "";
  String status = "";
  String inspector = "";
  String status_comment = "";
  String have_adequate_storage = "";
  String seed_grower_in_past = "";
  String type = "";
  String receipt = "";

  static Future<List<FormSr6Model>> get_items() async {
    List<DynamicTable> items = [];
    List<FormSr6Model> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          FormSr6Model item = new FormSr6Model();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.name_of_applicant = map['name_of_applicant'].toString();
            item.address = map['address'].toString();
            item.company_initials = map['company_initials'].toString();
            item.premises_location = map['premises_location'].toString();
            item.years_of_expirience = map['years_of_expirience'].toString();
            item.dealers_in = map['dealers_in'].toString();
            item.previous_grower_number =
                map['previous_grower_number'].toString();
            item.cropping_histroy = map['cropping_histroy'].toString();
            item.have_adequate_isolation =
                map['have_adequate_isolation'].toString();
            item.aware_of_minimum_standards =
                map['aware_of_minimum_standards'].toString();
            item.have_adequate_labor = map['have_adequate_labor'].toString();
            item.signature_of_applicant =
                map['signature_of_applicant'].toString();
            item.grower_number = map['grower_number'].toString();
            item.registration_number = map['registration_number'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.status = map['status'].toString();
            item.inspector = map['inspector'].toString();
            item.status_comment = map['status_comment'].toString();
            item.have_adequate_storage =
                map['have_adequate_storage'].toString();
            item.seed_grower_in_past = map['seed_grower_in_past'].toString();
            item.type = map['type'].toString();
            item.receipt = map['receipt'].toString();

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

  dynamic get_details()  {
    return {
      'title': "${this.type} certificate",
      'data': [
        KeyValue('Certificate ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('GROWER NUMBER', Utils.string_parse("${this.grower_number}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Applicant name', Utils.string_parse(this.name_of_applicant, "-")),
        /*KeyValue('Company initials', Utils.string_parse(this.company_initials, "-")),*/
        KeyValue('Address of applicant', Utils.string_parse(this.address, "-")),
        KeyValue('Premises location', Utils.string_parse(this.premises_location, "-")),
        KeyValue('Years of experience', Utils.int_parse("${this.years_of_expirience}").toString()),
        KeyValue('Production of', Utils.string_parse("${this.dealers_in}", "-")),
        KeyValue('Have adequate storage facilities to handle the resultant seed?', Utils.yes_no_parse("${this.have_adequate_storage}")),
        KeyValue('Have not been a seed grower in the past?',Utils.yes_no_parse("${this.seed_grower_in_past}")),
        KeyValue('Previous grower number', Utils.string_parse("${this.previous_grower_number}", '-')),
        KeyValue('Crop history for the last three season or years', Utils.string_parse("${this.cropping_histroy}", '-')),
        KeyValue('Have adequate storage facilities to handle the resultant seed?',Utils.yes_no_parse("${this.have_adequate_storage}")),
        KeyValue('Have adequate isolation?',Utils.yes_no_parse("${this.have_adequate_isolation}")),
        KeyValue('Have adequate labor to carry out all farm operations in a timely manner?',Utils.yes_no_parse("${this.have_adequate_labor}")),
        KeyValue('Aware that only seed that meets the minimum standards shall be accepted as certified seed?',Utils.yes_no_parse("${this.aware_of_minimum_standards}")),
        KeyValue('Inspector\'s comment', Utils.string_parse("${this.status_comment}", '-')),
      ]
    };
  }
}