import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class FormImportPermitModel {
  static String end_point = "import-permit/list";
  int id = 0;
  int administrator_id = 0;
  String name = "";
  String address = "";
  String telephone = "";
  String national_seed_board_reg_num = "";
  String store_location = "";
  int quantiry_of_seed = 0;
  String name_address_of_origin = "";
  String details = "";
  String ista_certificate = "";
  String valid_from = "";
  String valid_until = "";
  String status = "";
  String inspector = "";
  String status_comment = "";
  String permit_number = "";
  bool is_import = true;
  String phytosanitary_certificate = "";
  String category = "";
  String type = "";
  String crop_category = "";
  String other_varieties = "";
  String created_at = "";

  static Future<List<FormImportPermitModel>> get_items() async {
    List<DynamicTable> items = [];
    List<FormImportPermitModel> _items = [];

    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          FormImportPermitModel item = new FormImportPermitModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.name = map['name'].toString();
            item.address = map['address'].toString();
            item.telephone = map['telephone'].toString();
            item.national_seed_board_reg_num =
                map['national_seed_board_reg_num'].toString();
            item.store_location = map['store_location'].toString();
            item.quantiry_of_seed =
                Utils.int_parse(map['quantiry_of_seed'].toString());
            item.name_address_of_origin =
                map['name_address_of_origin'].toString();
            item.details = map['details'].toString();
            item.ista_certificate = map['valid_from'].toString();
            item.valid_from = map['valid_from'].toString();
            item.valid_until = map['valid_until'].toString();
            item.status = map['status'].toString();
            item.inspector = map['inspector'].toString();
            item.status_comment = map['status_comment'].toString();
            item.permit_number = map['permit_number'].toString();
            item.other_varieties = map['other_varieties'].toString();

            item.is_import = Utils.bool_parse(map['is_import']);
            item.phytosanitary_certificate =
                map['phytosanitary_certificate'].toString();
            item.category = map['category'].toString();
            item.type = map['type'].toString();
            item.crop_category = map['crop_category'].toString();
            item.created_at = map['created_at'].toString();

            if (item.is_import) {
              _items.add(item);
            }
          }
        }
      }
    });
    _items.sort((a, b) => a.id.compareTo(b.id));
    return _items;
  }
  dynamic get_details()  {
    return {
      'title': "${this.name} Permit Details",
      'data': [
        KeyValue('ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue(
            'Permit Number', Utils.string_parse("${this.permit_number}", "-")),
        KeyValue('Name', Utils.string_parse(this.name, "-")),
        KeyValue('Address', Utils.string_parse(this.address, "-")),
        KeyValue('Telephone', Utils.string_parse(this.telephone, "-")),
        //KeyValue('Seed Board No.', Utils.string_parse(this.national_seed_board_reg_num, "-")),
        KeyValue(
            'Store Location', Utils.string_parse(this.store_location, "-")),
        KeyValue(
            'Seed Quantity (in metric tons)', Utils.string_parse(this.quantiry_of_seed, "-")),
        KeyValue('Address of Origin',
            Utils.string_parse(this.name_address_of_origin, "-")),
        KeyValue('Details', Utils.string_parse(this.details, "-")),
        KeyValue('Is Certificate Certified?',
            Utils.string_parse("${this.ista_certificate}", "No")),
        KeyValue('Valid from', Utils.string_parse("${this.valid_from}", "-")),
        KeyValue('Valid until', Utils.string_parse("${this.valid_until}", "-")),
        KeyValue('Status', Utils.string_parse("${this.status}", "-")),
        KeyValue('Comment', Utils.string_parse("${this.status_comment}", "-")),

        KeyValue('Phytosanitary Certificate',
            Utils.string_parse("${this.phytosanitary_certificate}", "-")),
        KeyValue('Type', Utils.string_parse("${this.type}", "-")),
        KeyValue(
            'Crop Category', Utils.string_parse("${this.crop_category}", "-")),
        KeyValue('Other varieties',
            Utils.string_parse("${this.other_varieties}", "-")),
      ]
    };
  }

  static delete_item(int id) async {
    List<DynamicTable> items =
    await DynamicTable.get_local_items(endpoint: end_point);
    int y = 0;
    for (y = 0; y < items.length; y++) {
      if(items[y].id == id){
        await items[y].delete();
      }
    }
    return;
  }
}
