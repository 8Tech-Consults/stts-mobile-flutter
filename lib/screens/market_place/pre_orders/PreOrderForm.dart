import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:provider/provider.dart';

import '../../../models/CropsModel.dart';
import '../../../models/LoggedInUserModel.dart';
import '../../../models/PreOrderModel.dart';
import '../../../models/RespondModel.dart';
import '../../../models/option_picker_model.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/app_config.dart';
import '../../../utils/Utils.dart';
import '../../../widgets/my_widgets.dart';
import '../../option_pickers/single_option_picker.dart';

class PreOrderForm extends StatefulWidget {
  @override
  State<PreOrderForm> createState() => PreOrderFormState();
}

late CustomTheme customTheme;

class PreOrderFormState extends State<PreOrderForm> {
  String nature_of_off = "";

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
  }

  @override
  void dipose() {}

  bool isDark = false;
  bool is_loading = false;
  bool main_loading = false;
  String select_crop_text = "";
  String crop_variety_id = "";
  List<String> select_crop_id = [];
  PreOrderModel item = new PreOrderModel();

  List<PreOrderModel> importPermit = [];

  Future<bool> init_form() async {
    return true;
    // importPermit = await PreOrderModel.get_items();
    // if (importPermit.isEmpty) {
    //   importPermit = await PreOrderModel.get_items();
    // }
    // if (importPermit.isEmpty) {
    //   return true;
    // }
    //
    //
    // item = importPermit[(importPermit.length - 1)];
    //
    // return true;
  }

  void do_upload_process() async {
    if (crop_variety_id.isEmpty) {
      Utils.showSnackBar("Select at least one crop variety", context,
          background_color: Colors.red);
      return;
    }

    error_message = "";
    setState(() {});
    LoggedInUserModel u = await LoggedInUserModel.get_logged_in_user();

    Map<String, dynamic> f = {};

    f["crop_variety_id"] = crop_variety_id.toString();
    f["quantity"] = _fKey.currentState?.fields['quantity']?.value;
    f["seed_class"] = _fKey.currentState?.fields['seed_class']?.value;

    f["collection_date"] = _fKey.currentState?.fields['collection_date']?.value;
    f["pickup_location"] = _fKey.currentState?.fields['pickup_location']?.value;
    f["detail"] = _fKey.currentState?.fields['detail']?.value;

    is_loading = true;
    setState(() {});

    String raw = await Utils.http_post('pre-order/new', f);

    RespondModel resp = RespondModel(raw);

    is_loading = false;
    setState(() {});

    if (resp.code != 1) {
      error_message = resp.message;
      Utils.showSnackBar(resp.message, context, background_color: Colors.red);
      return;
    }

    Navigator.pop(context, {"task": 'success'});
    Utils.showSnackBar(resp.message, context, background_color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();

    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.primary,
          // remove back button in appbar.

          elevation: 1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: FxSpacing.x(0),
                    child: Icon(
                      CupertinoIcons.clear,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      'Pre-order Form',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: 700,
                    ),
                  ],
                ),
              ),
              Expanded(child: Text("")),
              (is_loading)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        do_upload_process();
                      },
                      child: Container(
                          padding: FxSpacing.x(10),
                          child: Icon(
                            CupertinoIcons.check_mark,
                            size: 25,
                            color: Colors.white,
                          )),
                    ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: init_form(),
            builder: (context, snapshot) => FormBuilder(
                  key: _fKey,
                  child: Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            top: 5,
                                            right: 15,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              FormBuilderTextField(
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  name: "select_crop_text",
                                                  readOnly: true,
                                                  minLines: 2,
                                                  maxLines: 5,
                                                  initialValue:
                                                      select_crop_text,
                                                  onTap: () {
                                                    pick_crop();
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: customTheme
                                                      .inputDecoration3(
                                                    labelText:
                                                        "Select crop variety",
                                                  )),
                                              SizedBox(height: 10),
                                              FormBuilderTextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: customTheme
                                                    .inputDecoration3(
                                                  labelText:
                                                      "Quantity (in Metric tonnes)",
                                                ),
                                                name: "quantity",
                                                validator: MyWidgets
                                                    .my_validator_field_required(
                                                        context, 'Quantity'),
                                                textInputAction:
                                                    TextInputAction.next,
                                              ),
                                              SizedBox(height: 10),
                                              FormBuilderDropdown(
                                                decoration: customTheme
                                                    .inputDecoration3(
                                                  labelText: "Seed class",
                                                ),
                                                name: "seed_class",
                                                dropdownColor: Colors.white,
                                                validator: MyWidgets
                                                    .my_validator_field_required(
                                                        context, 'Seed Class '),
                                                items: AppConfig.seedClasses
                                                    .map((options) =>
                                                        DropdownMenuItem(
                                                          value: options,
                                                          child: Text(options),
                                                        ))
                                                    .toList(),
                                              ),
                                              const SizedBox(height: 10),
                                              FormBuilderDateTimePicker(
                                                name: 'collection_date',
                                                // onChanged: _onChanged,
                                                inputType: InputType.date,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Collection date',
                                                ),
                                                initialTime: const TimeOfDay(
                                                    hour: 8, minute: 0),
                                                initialValue: DateTime.now(),
                                                // enabled: true,
                                              ),
                                              SizedBox(height: 10),
                                              FormBuilderTextField(
                                                decoration: customTheme
                                                    .inputDecoration3(
                                                  labelText: "Pickup Location",
                                                ),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                name: "pickup_location",
                                                validator: MyWidgets
                                                    .my_validator_field_required(
                                                        context,
                                                        'Pickup Location'),
                                                textInputAction:
                                                    TextInputAction.next,
                                              ),
                                              SizedBox(height: 10),
                                              FormBuilderTextField(
                                                decoration: customTheme
                                                    .inputDecoration3(
                                                  labelText: "Details",
                                                ),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                name: "detail",
                                                minLines: 2,
                                                maxLines: 5,
                                                validator: MyWidgets
                                                    .my_validator_field_required(
                                                        context, 'Details'),
                                                textInputAction:
                                                    TextInputAction.newline,
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                              childCount: 1, // 1000 list items
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: (is_loading)
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red),
                                  ),
                                ),
                              )
                            : FxButton.block(
                                borderRadiusAll: 0,
                                onPressed: () {
                                  //showMyDialog(context);
                                  do_upload_process();
                                },
                                backgroundColor: CustomTheme.primary,
                                child: FxText(
                                  "SUBMIT",
                                  fontSize: 18,
                                  color: customTheme.cookifyOnPrimary,
                                )),
                      )
                    ],
                  ),
                )),
      );
    });
  }

  final _fKey = GlobalKey<FormBuilderState>();
  String error_message = "";

  String location_sub_name = "";
  String location_id = "";
  bool is_uploading = false;

//pick crop
  pick_crop() async {
    if (is_loading) {
      return;
    }
    setState(() {
      //is_loading = true;
    });

    List<CropsModel> items = await CropsModel.get_items();
    List<OptionPickerModel> local_items = [];
    items.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = "1";
      item.id = element.id.toString();
      item.name = element.name.toString();
      local_items.add(item);
    });

    setState(() {
      is_loading = false;
    });
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleOptionPicker(
              "Select a crops", local_items, select_crop_id, true)),
    );

    if (result != null) {
      if ((result['selected'] != null)) {
        select_crop_text = "";

        List<String> selected_items = [];

        result['selected'].map((element) {
          selected_items.add(element.toString());
        }).toList();

        bool is_first = true;
        crop_variety_id = "";

        items.forEach((element) {
          if (selected_items.contains(element.id.toString())) {
            if (is_first) {
              is_first = false;
              crop_variety_id = element.id.toString();
              select_crop_text += element.name.toString();
            } else {
              select_crop_text += ", " + element.name.toString();
            }
          }
        });
        _fKey.currentState?.patchValue({
          'select_crop_text': select_crop_text,
        });

        setState(() {});
      }
    }
  }

//end pick crop

  showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _InternetCheckDialog();
        });
  }
}

class _InternetCheckDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        decoration: new BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                size: 40,
                color: theme.colorScheme.onBackground.withAlpha(220),
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: FxText("No Internet!", fontWeight: 700)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: FxText("Please turn on internet", fontWeight: 500)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: FxButton(
                    elevation: 2,
                    borderRadiusAll: 4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: FxText("CREATE ANOTHER TASK",
                        fontWeight: 600,
                        letterSpacing: 0.3,
                        color: theme.colorScheme.onPrimary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
