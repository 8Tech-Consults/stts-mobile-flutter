import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class FormStockExaminationRequestModel {
  static String end_point = "form-stock-examination-requests/list";
  int id = 0;
  int administrator_id = 0;
  String created_at = "";
  String import_export_permit_id = "";
  String planting_return_id = "";
  String form_qds_id = "";
  String field_size = "";
  String yield = "";
  String date = "";
  String purity = "";
  String germination = "";
  String moisture_content = "";
  String insect_damage = "";
  String moldiness = "";
  String noxious_weeds = "";
  String recommendation = "";
  String status = "";
  String inspector = "";
  String status_comment = "";
  String remarks = "";
  String examination_category = "";
  String crop_variety_id = "";
  String seed_class = "";
  String lot_number = "";

  static Future<List<FormStockExaminationRequestModel>> get_items() async {
    List<DynamicTable> items = [];
    List<FormStockExaminationRequestModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          FormStockExaminationRequestModel item = new FormStockExaminationRequestModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());
            item.created_at = map['created_at'].toString();
            item.created_at = map['created_at'].toString();
            item.import_export_permit_id =
                map['import_export_permit_id'].toString();
            item.planting_return_id = map['planting_return_id'].toString();
            item.form_qds_id = map['form_qds_id'].toString();
            item.field_size = map['field_size'].toString();
            item.yield = map['yield'].toString();
            item.date = map['date'].toString();
            item.purity = map['purity'].toString();
            item.germination = map['germination'].toString();
            item.moisture_content = map['moisture_content'].toString();
            item.insect_damage = map['insect_damage'].toString();
            item.moldiness = map['moldiness'].toString();
            item.noxious_weeds = map['noxious_weeds'].toString();
            item.recommendation = map['recommendation'].toString();
            item.status = map['status'].toString();
            item.inspector = map['inspector'].toString();
            item.status_comment = map['status_comment'].toString();
            item.remarks = map['remarks'].toString();
            item.examination_category = map['examination_category'].toString();
            item.crop_variety_id = map['crop_variety_id'].toString();
            item.seed_class = map['seed_class'].toString();
            item.lot_number = map['lot_numbe'].toString();
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

  static category_to_int(String data) {
    if (data == 'Imported seed') {
      return 1;
    } else if (data == 'Grower seed') {
      return 2;
    } else {
      return 3;
    }
  }

  static category_to_string(String data) {
    if (data.toString() == '1') {
      return 'Imported seed';
    } else if (data == '2') {
      return 'Grower seed';
    } else {
      return 'QDS';
    }
  }

  dynamic get_details() {
    return {
      'title': "My stock examination",
      'data': [
        KeyValue('Examination category',
            category_to_string(this.examination_category)),
        KeyValue('Examination ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('status', Utils.tell_status(this.status) ),
        KeyValue('Status comment', Utils.tell_status(this.status_comment)),
        KeyValue(
            'Import export permit ID',
            Utils.string_parse(
                "#${Utils.string_parse(this.import_export_permit_id, "")}",
                "-")),
        KeyValue(
            'Export export permit ID',
            Utils.string_parse(
                "#${Utils.string_parse(this.import_export_permit_id, "")}",
                "-")),
        KeyValue(
            'Crop variety ID',
            Utils.string_parse(
                "#${Utils.string_parse(this.crop_variety_id, "")}", "-")),
        KeyValue(
            'Lot number',
            Utils.string_parse(
                "#${Utils.string_parse(this.lot_number, "")}", "-")),
        KeyValue('Seed class', Utils.string_parse(this.seed_class, "-")),
        KeyValue('QDS ID',
            Utils.string_parse("#${this.form_qds_id}", "-")),
        KeyValue('Field size', Utils.string_parse(this.field_size, "-")),
        KeyValue('Yield', Utils.string_parse(this.yield, "-")),
        KeyValue('Date of collection', Utils.string_parse(this.date, "-")),
        KeyValue('Purity', Utils.string_parse(this.purity, "-")),
        KeyValue('Germination', Utils.string_parse(this.germination, "-")),
        KeyValue(
            'Moisture content', Utils.string_parse(this.moisture_content, "-")),
        KeyValue('Insect damage', Utils.string_parse(this.insect_damage, "-")),
        KeyValue('Moldiness', Utils.string_parse(this.moldiness, "-")),
        KeyValue('Noxious weeds', Utils.string_parse(this.noxious_weeds, "-")),
        KeyValue(
            'Recommendation', Utils.string_parse(this.recommendation, "-")),
        KeyValue('Remarks', Utils.string_parse(this.remarks, "-")),
      ]
    };
  }
}
