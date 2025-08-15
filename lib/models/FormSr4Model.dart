import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class FormSr4Model {
  static String end_point = "form-sr4/list";
  int id = 0;
  int administrator_id = 0;
  String name_of_applicant = "";
  String address = "";
  String created_at = "";
  String company_initials = "";
  String premises_location = "";
  String years_of_expirience = "";
  String expirience_in = "";
  String dealers_in = "";
  String processing_of = "";
  String marketing_of = "";
  String have_adequate_land = "";
  String land_size = "";
  String eqipment = "";
  String have_adequate_equipment = "";
  String have_contractual_agreement = "";
  String have_adequate_field_officers = "";
  String have_conversant_seed_matters = "";
  String souce_of_seed = "";
  String have_adequate_land_for_production = "";
  String have_internal_quality_program = "";
  String receipt = "";
  String accept_declaration = "";
  String valid_from = "";
  String valid_until = "";
  String status = "";
  String status_comment = "";
  String inspector = "";
  String dealers_in_other = "";
  String processing_of_other = "";
  String marketing_of_other = "";
  String souce_of_seed_other = "";
  String have_adequate_storage = "";
  String seed_board_registration_number = "";
  String type = "";

  static Future<List<FormSr4Model>> get_items() async {
    List<DynamicTable> items = [];
    List<FormSr4Model> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          FormSr4Model item = new FormSr4Model();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.name_of_applicant = map['name_of_applicant'].toString();
            item.address = map['address'].toString();
            item.created_at = map['created_at'].toString();
            item.company_initials = map['company_initials'].toString();
            item.premises_location = map['premises_location'].toString();
            item.expirience_in = map['expirience_in'].toString();
            item.dealers_in = map['dealers_in'].toString();
            item.processing_of = map['processing_of'].toString();
            item.marketing_of = map['marketing_of'].toString();
            item.have_adequate_land = map['have_adequate_land'].toString();
            item.land_size = map['land_size'].toString();
            item.eqipment = map['eqipment'].toString();
            item.have_adequate_equipment =
                map['have_adequate_equipment'].toString();
            item.have_contractual_agreement =
                map['have_contractual_agreement'].toString();
            item.have_adequate_field_officers =
                map['have_adequate_field_officers'].toString();
            item.have_conversant_seed_matters =
                map['have_conversant_seed_matters'].toString();
            item.souce_of_seed = map['souce_of_seed'].toString();
            item.have_adequate_land_for_production =
                map['have_adequate_land_for_production'].toString();
            item.have_internal_quality_program =
                map['have_internal_quality_program'].toString();
            item.receipt = map['receipt'].toString();
            item.accept_declaration = map['accept_declaration'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.status = map['status'].toString();
            item.status_comment = map['status_comment'].toString();
            item.inspector = map['inspector'].toString();
            item.dealers_in_other = map['dealers_in_other'].toString();
            item.processing_of_other = map['processing_of_other'].toString();
            item.marketing_of_other = map['marketing_of_other'].toString();
            item.souce_of_seed_other = map['souce_of_seed_other'].toString();
            item.have_adequate_storage =
                map['have_adequate_storage'].toString();
            item.seed_board_registration_number =
                map['seed_board_registration_number'].toString();
            item.type = map['type'].toString();

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
      'title': "${this.type} certificate",
      'data': [
        KeyValue('Certificate ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue(
            'Applicant name', Utils.string_parse(this.name_of_applicant, "-")),
        KeyValue(
            'Company initials', Utils.string_parse(this.company_initials, "-")),
        KeyValue('Address of applicant', Utils.string_parse(this.address, "-")),
        KeyValue('Premises location',
            Utils.string_parse(this.premises_location, "-")),
        KeyValue('Seed board registration number',
            Utils.string_parse("#${this.seed_board_registration_number}", "-")),
        /*KeyValue('Years of experience',
            Utils.int_parse("${this.years_of_expirience}").toString()),*/
        KeyValue(
            'Experience', Utils.string_parse("${this.expirience_in}", "-")),
        KeyValue(
            'Production of', Utils.string_parse("${this.dealers_in}", "-")),
        KeyValue('Market of', Utils.string_parse("${this.marketing_of}", "-")),
        KeyValue('Have adequate land to handle basic seed?',
            Utils.yes_no_parse("${this.have_adequate_land}")),
        KeyValue(
            'Have adequate storage facilities to handle the resultant seed?',
            Utils.yes_no_parse("${this.have_adequate_storage}")),
        KeyValue('Have adequate equipment to handle basic seed?',
            Utils.yes_no_parse("${this.have_adequate_equipment}")),
        KeyValue('Equipment to handle basic seed',
            Utils.string_parse("${this.eqipment}", "-")),
        KeyValue(
            'Have contractual agreement with the growers you have recruited?',
            Utils.yes_no_parse("${this.have_contractual_agreement}")),
        KeyValue(
            'Have adequate field officers to supervise and advise growers on all operation of seed production?',
            Utils.yes_no_parse("${this.have_adequate_field_officers}")),
        KeyValue(
            'Have adequate and knowledgeable personal who are conversant with seed matters?',
            Utils.yes_no_parse("${this.have_conversant_seed_matters}")),
        KeyValue('Have an internal quality program',
            Utils.yes_no_parse("${this.have_internal_quality_program}")),
        KeyValue('Inspector\'s comment', Utils.string_parse("${this.status_comment}", '-')),
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
