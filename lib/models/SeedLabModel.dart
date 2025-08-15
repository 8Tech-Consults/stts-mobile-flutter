import 'dart:convert';

import '../utils/Utils.dart';
import 'DynamicTable.dart';
import 'KeyValue.dart';

class SeedLabModel {
  static String end_point = "seed-labs/list";
  int id = 0;
  int administrator_id = 0;
  int crop_variety_id =0;
  int form_stock_examination_request_id=0;
  String collection_date="";
  String payment_receipt="";
  String applicant_remarks="";
  String sampling_date="";
  String sample_weight="";
  String packaging="";
  String number_of_units="";
  String mother_lot="";
  String sample_condition="";
  String inspector_remarks="";
  String crop_variety_text="";
  String tests_required="";
  String lab_technician_id="";
  String quantity="";
  String purity="";
  String germination_capacity="";
  String abnormal_sprouts="";
  String broken_germs="";
  String report_recommendation="";
  String inspector="";
  String inspector_is_done="";
  String status="";
  String status_comment="";
  String lot_number="";
  String receptionist_is_done="";
  String receptionist_remarks="";
  String lab_test_number="";
  String lab_technician="";
  String p_x_g="";
  String parent_id="";
  String order="";
  String title="";
  String temp_parent="";
  String created_at="";

  static Future<List<SeedLabModel>> get_items() async {
    List<DynamicTable> items = [];
    List<SeedLabModel> _items = [];
    items = await DynamicTable.get_items(
        end_point: end_point, clear_previous: true, params: {});

    items.forEach((element) {
      Map<dynamic, dynamic> map = jsonDecode(element.data);
      if (map != null) {
        if (map['id'] != null) {
          SeedLabModel item = new SeedLabModel();
          item.id = Utils.int_parse(map['id']);
          if (item.id > 0) {
            item.administrator_id =
                Utils.int_parse(map['administrator_id'].toString());

            item.crop_variety_id = Utils.int_parse(map['crop_variety_id'].toString());
            item.form_stock_examination_request_id =Utils.int_parse(map['form_stock_examination_request_id'].toString());
            item.collection_date = map['collection_date'].toString();
            item.created_at = map['created_at'].toString();
            item.payment_receipt = map['payment_receipt'].toString();
            item.applicant_remarks = map['applicant_remarks'].toString();
            item.sampling_date = map['sampling_date'].toString();
            item.sample_weight = map['sample_weight'].toString();
            item.packaging = map['packaging'].toString();
            item.number_of_units = map['number_of_units'].toString();
            item.mother_lot = map['mother_lot'].toString();
            item.sample_condition = map['sample_condition'].toString();
            item.inspector_remarks = map['inspector_remarks'].toString();
            item.tests_required = map['tests_required'].toString();
            item.lab_technician_id = map['lab_technician_id'].toString();
            item.quantity = map['quantity'].toString();
            item.purity = map['purity'].toString();
            item.germination_capacity = map['germination_capacity'].toString();
            item.abnormal_sprouts = map['abnormal_sprouts'].toString();
            item.broken_germs = map['broken_germs'].toString();
            item.report_recommendation = map['report_recommendation'].toString();
            item.inspector = map['inspector'].toString();
            item.inspector_is_done = map['inspector_is_done'].toString();
            item.status = map['status'].toString();
            item.status_comment = map['status_comment'].toString();
            item.lot_number = map['lot_number'].toString();
            item.receptionist_is_done = map['receptionist_is_done'].toString();
            item.lab_test_number = map['lab_test_number'].toString();
            item.lab_technician = map['lab_technician'].toString();
            item.p_x_g = map['p_x_g'].toString();
            item.parent_id = map['parent_id'].toString();
            item.order = map['order'].toString();
            item.title = map['title'].toString();
            item.crop_variety_text = map['crop_variety_text'].toString();
            item.temp_parent = map['temp_parent'].toString();
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
      'title': "${this.crop_variety_id} Seed Lab",
      'data': [
        KeyValue('Seed Lab ID', Utils.string_parse("#${this.id}", "-")),
        KeyValue('Created', Utils.string_parse(this.created_at, "-")),
        KeyValue('Crop', Utils.string_parse(this.crop_variety_text, "-")),

        KeyValue(
            'LOT Number', Utils.string_parse(this.lot_number, "-")),
        KeyValue(
            'Mother LOT', Utils.string_parse(this.mother_lot, "-")),

        KeyValue('Form Examination Request',
            Utils.string_parse(this.form_stock_examination_request_id, "-")),

        KeyValue(
            'Collection Date', Utils.string_parse(this.collection_date, "-")),

        KeyValue(
            'Sampling date', Utils.string_parse(this.sampling_date, "-")),


        KeyValue('Quantity', Utils.string_parse(this.quantity, "-")),

        KeyValue(
            'Sample weight', Utils.string_parse(this.sample_weight, "-")),

        KeyValue(
            'Packaging', Utils.string_parse(this.packaging, "-")),

        KeyValue(
            'Number of units', Utils.string_parse(this.number_of_units, "-")),



        KeyValue(
            'Sample condition', Utils.string_parse(this.sample_condition, "-")),

        KeyValue(
            'Purity', Utils.string_parse(this.purity, "-")),

        KeyValue(
            'PXG', Utils.string_parse(this.p_x_g, "-")),

        KeyValue(
            'Germination capacity', Utils.string_parse(this.germination_capacity, "-")),


        KeyValue(
            'Abnormal sprouts', Utils.string_parse(this.abnormal_sprouts, "-")),


        KeyValue(
            'Broken germs', Utils.string_parse(this.broken_germs, "-")),


        KeyValue(
            'Report recommendation', Utils.string_parse(this.report_recommendation, "-")),


        KeyValue('Applicant Remarks',
            Utils.string_parse("#${this.applicant_remarks}", "-")),
        KeyValue('Status', Utils.tell_status(this.status)),
        KeyValue('Remarks on status',
            Utils.string_parse("${this.status_comment}", "-")),

        KeyValue('Inspector remarks',
            Utils.string_parse("${this.inspector_remarks}", "-")),



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
