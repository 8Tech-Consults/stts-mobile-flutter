import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:provider/provider.dart';
import '../../../models/PlantingReturnsModel.dart';
import '../../../models/LoggedInUserModel.dart';
import '../../../models/RespondModel.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/Utils.dart';
import '../../../widgets/my_widgets.dart';

class CompanyPlantingReturnForm extends StatefulWidget {
  @override
  State<CompanyPlantingReturnForm> createState() =>
      CompanyPlantingReturnFormState();
}

late CustomTheme customTheme;

class CompanyPlantingReturnFormState extends State<CompanyPlantingReturnForm> {
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
  PlantingReturnsModel item = new PlantingReturnsModel();

  List<PlantingReturnsModel> companygrower = [];

  Future<bool> init_form() async {
    companygrower = await PlantingReturnsModel.get_items();
    if (companygrower.isEmpty) {
      companygrower = await PlantingReturnsModel.get_items();
    }
    if (companygrower.isEmpty) {
      return true;
    }

    item = companygrower[(companygrower.length - 1)];

    _fKey.currentState?.patchValue({
      'name': item.name,
      'address': item.address,
      'telephone': item.telephone,
      'seed_rate': item.seed_rate,
      'registerd_dealer': item.registerd_dealer,
      'amount_enclosed': item.amount_enclosed,
      'payment_receipt': item.payment_receipt,
      'sub_growers_file': item.sub_growers_file,
    });

    return true;
  }

  void do_upload_process() async {
    error_message = "";
    setState(() {});
    LoggedInUserModel u = await LoggedInUserModel.get_logged_in_user();

    if (!_fKey.currentState!.validate()) {
      Utils.showSnackBar(
        "Please Check errors in the form and fix them first.",
        context,
        background_color: Colors.red,
      );
      return;
    }

    Map<String, dynamic> f = {};

    f["name"] = _fKey.currentState?.fields['name']?.value;
    f["address"] = _fKey.currentState?.fields['address']?.value;
    f["telephone"] = _fKey.currentState?.fields['telephone']?.value;
    f["seed_rate"] = _fKey.currentState?.fields['seed_rate']?.value;
    f["registerd_dealer"] =
        _fKey.currentState?.fields['registerd_dealer']?.value;
    f["payment_receipt"] = _fKey.currentState?.fields['payment_receipt']?.value;
    f["sub_growers_file"] =
        _fKey.currentState?.fields['sub_growers_file']?.value;

    is_loading = true;
    setState(() {});

    RespondModel resp = RespondModel(
      await Utils.http_post('planting-returns-company/new/', f),
    );
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
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText(
                        'Company Planting Return',
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red,
                            ),
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
                          ),
                        ),
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
                                              TextCapitalization.sentences,
                                          name: "name",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Company Name',
                                              ),
                                          textInputAction: TextInputAction.next,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Company Name",
                                              ),
                                        ),
                                        SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Company Address",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "address",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Company Address',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.phone,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Phone number",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "telephone",
                                          minLines: 1,
                                          maxLines: 3,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Phone number',
                                              ),
                                          textInputAction:
                                              TextInputAction.newline,
                                        ),
                                        SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme.inputDecoration3(
                                            labelText:
                                                "Amount enclosed for application",
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "amount_enclosed",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Amount',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme.inputDecoration3(
                                            labelText:
                                                "Registered seed merchant/dealer",
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "registerd_dealer",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Registered seed merchant/dealer',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
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
                                  Colors.red,
                                ),
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
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final _fKey = GlobalKey<FormBuilderState>();
  String error_message = "";

  //end pick varieties

  showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _InternetCheckDialog();
      },
    );
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
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: FxText("No Internet!", fontWeight: 700)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: FxText("Please turn on internet", fontWeight: 500),
              ),
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
                  child: FxText(
                    "CREATE ANOTHER TASK",
                    fontWeight: 600,
                    letterSpacing: 0.3,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
