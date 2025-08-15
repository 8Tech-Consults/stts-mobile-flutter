import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';

class EmployeeModel {
  static String end_point = "employees";
  int id = 0;
  int enterprise_id = 0;
  String username = "";
  String name = "";
  String avatar = "";
  String first_name = "";
  String last_name = "";
  String date_of_birth = "";
  String sex = "";
  String home_address = "";
  String current_address = "";
  String phone_number_1 = "";
  String phone_number_2 = "";
  String email = "";
  String nationality = "";
  String religion = "";
  String spouse_name = "";
  String spouse_phone = "";
  String father_name = "";
  String father_phone = "";
  String mother_phone = "";
  String languages = "";
  String emergency_person_name = "";
  String emergency_person_phone = "";
  String passport_number = "";
  String tin = "";
  String nssf_number = "";
  String bank_name = "";
  String bank_account_number = "";
  String primary_school_name = "";
  String primary_school_year_graduated = "";
  String seconday_school_name = "";
  String seconday_school_year_graduated = "";
  String high_school_name = "";
  String high_school_year_graduated = "";
  String degree_university_year_graduated = "";
  String masters_university_name = "";
  String masters_university_year_graduated = "";
  String phd_university_name = "";
  String phd_university_year_graduated = "";

  static Future<List<EmployeeModel>> get_items() async {
    List<DynamicTable> items = [];
    List<EmployeeModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          EmployeeModel item = new EmployeeModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.enterprise_id =
                Utils.int_parse(map['enterprise_id'].toString());

            item.enterprise_id =
                Utils.int_parse(map['enterprise_id'].toString());

            item.username = map['username'].toString();
            item.name = map['name'].toString();
            item.avatar = map['avatar'].toString();
            item.first_name = map['first_name'].toString();
            item.last_name = map['last_name'].toString();
            item.date_of_birth = map['date_of_birth'].toString();
            item.sex = map['sex'].toString();
            item.home_address = map['home_address'].toString();
            item.current_address = map['current_address'].toString();
            item.phone_number_1 = map['phone_number_1'].toString();
            item.phone_number_2 = map['phone_number_2'].toString();
            item.email = map['email'].toString();
            item.nationality = map['nationality'].toString();
            item.religion = map['religion'].toString();
            item.spouse_name = map['spouse_name'].toString();
            item.spouse_phone = map['spouse_phone'].toString();
            item.father_name = map['father_name'].toString();
            item.father_phone = map['father_phone'].toString();
            item.mother_phone = map['mother_phone'].toString();
            item.languages = map['languages'].toString();
            item.emergency_person_name =
                map['emergency_person_name'].toString();
            item.emergency_person_phone =
                map['emergency_person_phone'].toString();
            item.passport_number = map['passport_number'].toString();
            item.tin = map['tin'].toString();
            item.nssf_number = map['nssf_number'].toString();
            item.bank_name = map['bank_name'].toString();
            item.bank_account_number = map['bank_account_number'].toString();
            item.primary_school_name = map['primary_school_name'].toString();
            item.primary_school_year_graduated =
                map['primary_school_year_graduated'].toString();
            item.seconday_school_name = map['seconday_school_name'].toString();
            item.seconday_school_year_graduated =
                map['seconday_school_year_graduated'].toString();
            item.high_school_name = map['high_school_name'].toString();
            item.high_school_year_graduated =
                map['high_school_year_graduated'].toString();
            item.degree_university_year_graduated =
                map['degree_university_year_graduated'].toString();
            item.masters_university_name =
                map['masters_university_name'].toString();
            item.masters_university_year_graduated =
                map['masters_university_year_graduated'].toString();
            item.phd_university_name = map['phd_university_name'].toString();
            item.phd_university_year_graduated =
                map['phd_university_year_graduated'].toString();

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
