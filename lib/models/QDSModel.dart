import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class QDSModel {
  static String end_point = "form-qds/list";
  int id = 0;
  int administrator_id = 0;
  String created_at = "";
  String name_of_applicant = "";
  String address = "";
  String company_initials = "";
  String years_of_expirience = "";
  String premises_location = "";
  String dealers_in = "";
  String previous_grower_number = "";
  String cropping_histroy = "";
  String have_adequate_isolation = "";
  String have_adequate_labor = "";
  String aware_of_minimum_standards = "";
  String signature_of_applicant = "";
  String grower_number = "";
  String registration_number = "";
  String valid_from = "";
  String valid_until = "";
  String status = "";
  String inspector = "";
  String status_comment = "";
  String have_been_qds = "";
  String isolation_distance = "";
  String number_of_labors = "";
  String have_adequate_storage_facility = "";
  String is_not_used = "";
  String examination_category = "";

  static delete_all_items() async {
    List<DynamicTable> items =
        await DynamicTable.get_local_items(endpoint: end_point);
    int y = 0;
    for (y = 0; y < items.length; y++) {
      await items[y].delete();
    }
    return;
  }

  static Future<List<QDSModel>> get_items() async {
    List<DynamicTable> items = [];
    List<QDSModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          QDSModel item = new QDSModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.created_at = map['created_at'].toString();
            item.created_at = map['created_at'].toString();
            item.name_of_applicant = map['name_of_applicant'].toString();
            item.address = map['address'].toString();
            item.company_initials = map['company_initials'].toString();
            item.years_of_expirience = map['years_of_expirience'].toString();
            item.premises_location = map['premises_location'].toString();
            item.dealers_in = map['dealers_in'].toString();
            item.previous_grower_number =
                map['previous_grower_number'].toString();
            item.cropping_histroy = map['cropping_histroy'].toString();
            item.have_adequate_isolation =
                map['have_adequate_isolation'].toString();
            item.have_adequate_labor = map['have_adequate_labor'].toString();
            item.aware_of_minimum_standards =
                map['aware_of_minimum_standards'].toString();
            item.signature_of_applicant =
                map['signature_of_applicant'].toString();
            item.grower_number = map['grower_number'].toString();
            item.registration_number = map['registration_number'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.status = map['status'].toString();
            item.inspector = map['inspector'].toString();
            item.status_comment = map['status_comment'].toString();
            item.have_been_qds = map['have_been_qds'].toString();
            item.isolation_distance = map['isolation_distance'].toString();
            item.number_of_labors = map['number_of_labors'].toString();
            item.have_adequate_storage_facility =
                map['have_adequate_storage_facility'].toString();
            item.is_not_used = map['is_not_used'].toString();
            item.examination_category = map['examination_category'].toString();

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
      'title': "My QDS",
      'data': [
        KeyValue('QDS  ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Status', Utils.string_parse( Utils.tell_status(this.status) , "-")),
        KeyValue('Status comment', Utils.string_parse( this.status_comment , "-")),
        KeyValue('Created', Utils.string_parse("${this.created_at}", "-")),
        KeyValue('Valid from', Utils.string_parse("${this.valid_from}", "-")),
        KeyValue('Valid until', Utils.string_parse("${this.valid_until}", "-")),
        KeyValue('Name of applicant', Utils.string_parse("${this.name_of_applicant}", "-")),
        KeyValue('Address', Utils.string_parse("${this.address}", "-")),
/*        KeyValue('Company initials', Utils.string_parse("${this.company_initials}", "-")),*/
        KeyValue('Years of expirience', Utils.string_parse("${this.years_of_expirience}", "-")),
        KeyValue('Premises location', Utils.string_parse("${this.premises_location}", "-")),
/*        KeyValue('Crop', Utils.string_parse("${this.dealers_in}", "-")),*/
        KeyValue('Previous grower number', Utils.string_parse("${this.previous_grower_number}", "-")),
        KeyValue('Propping history', Utils.string_parse("${this.cropping_histroy}", "-")),
        KeyValue('Have adequate isolation?', Utils.string_parse("${Utils.yes_no_parse(this.have_adequate_isolation)}", "-")),
        KeyValue('Have adequate labor?', Utils.string_parse("${Utils.yes_no_parse(this.have_adequate_labor)}", "-")),
        KeyValue('Aware of minimum standards?', Utils.string_parse("${Utils.yes_no_parse(this.aware_of_minimum_standards)}", "-")),
        KeyValue('Have adequate storage facility?', Utils.string_parse("${Utils.yes_no_parse(this.have_adequate_storage_facility)}", "-")),
        KeyValue('Grower number', Utils.string_parse("${this.grower_number}", "-")),
        KeyValue('Registration number', Utils.string_parse("${this.registration_number}", "-")),
        KeyValue('Have been QDS producer?', Utils.string_parse("${Utils.yes_no_parse(this.have_been_qds)}", "-")),
        KeyValue('Isolation distance', Utils.string_parse("${this.isolation_distance}", "-")),
        KeyValue('Number of labors', Utils.string_parse("${this.number_of_labors}", "-")),

      ]
    };
  }
}
