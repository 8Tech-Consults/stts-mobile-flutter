import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:provider/provider.dart';

import '../../../models/QDSModel.dart';
import '../../../models/QDSModel.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/app_config.dart';
import '../../../utils/Utils.dart';
import '../../../widgets/my_widgets.dart';

class DetailsFormQDSScreen extends StatefulWidget {
  @override
  State<DetailsFormQDSScreen> createState() => DetailsFormQDSScreenState();
}

late CustomTheme customTheme;

class DetailsFormQDSScreenState extends State<DetailsFormQDSScreen> {
  String nature_of_off = "";

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    Utils.init_theme();
    super.initState();

    _do_refresh();
  }

  @override
  void dipose() {}

  List<QDSModel> qds = [];
  QDSModel item = new QDSModel();

  Future<Null> _do_refresh() async {
    return await _onRefresh(context);
  }

  Future<Null> _onRefresh(BuildContext _context) async {
    qds = await QDSModel.get_items();

    if (qds.isEmpty) {
      qds = await QDSModel.get_items();
    }
    if (qds.isEmpty) {
      Utils.showSnackBar("You don't have a QDS", context);
      Navigator.pop(context);
      return;
    }
    item = qds[(qds.length - 1)];
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();

    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: _do_refresh,
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    toolbarHeight: 210,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 20, bottom: 10),
                            child: FxText(
                              AppConfig.appName,
                              color: Colors.white,
                              fontSize: 23,
                              height: 1,
                              fontWeight: 800,
                              textAlign: TextAlign.center,
                            ),
                            width: double.infinity,
                            color: CustomTheme.primary,
                          ),
                          Container(
                            height: 10,
                            color: Colors.white,
                          ),
                          Image(
                            width: double.infinity,
                            height: 70,
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/maaif_1.png"),
                          ),
                          FxContainer(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: double.infinity,
                            child: FxText(
                              "Quality Declared Seed Producer CERTIFICATE"
                                  .toUpperCase(),
                              maxLines: 2,
                              color: Colors.black,
                              fontSize: 23,
                              height: 1,
                              fontWeight: 800,
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.white,
                            borderRadiusAll: 0,
                          ),
                        ],
                      ),
                    ),
                    floating: false,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          height: 1,
                          color: CustomTheme.primary,
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        );
                      },
                      childCount: 1, // 1000 list items
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return FxContainer(
                          borderRadiusAll: 0,
                          marginAll: 0,
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Certificate ID",
                                      "#" + item.id.toString()),
                                  MyWidgets.single_field_widget(
                                      "Created", item.created_at.toString())
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                    "Status",
                                    item.status,
                                    tell_status: true,
                                  ),
                                  MyWidgets.single_field_widget(
                                      "", item.status_comment.toString())
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Valid from", item.valid_from.toString()),
                                  MyWidgets.single_field_widget("Valid until",
                                      item.valid_until.toString())
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              FxDashedDivider(
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Name of applicant",
                                      item.name_of_applicant.toString()),
                                  MyWidgets.single_field_widget(
                                      "Address", item.address.toString())
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Company initials",
                                      item.company_initials.toString()),
                                  MyWidgets.single_field_widget(
                                      "Premises location",
                                      item.premises_location.toString())
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Years of experience",
                                      item.years_of_expirience.toString()),
                                  MyWidgets.single_field_widget(
                                      "Previous grower number",
                                      item.previous_grower_number.toString()),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Registration number",
                                      item.registration_number.toString()),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Cropping history",
                                      item.cropping_histroy.toString()),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have/has adequate isolation?",
                                      item.have_adequate_isolation.toString(),
                                      is_yes_no: true),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have been qds?",
                                      item.have_been_qds.toString(),
                                      is_yes_no: true),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have adequate isolation?",
                                      item.have_adequate_isolation.toString(),
                                      is_yes_no: true),
                                  MyWidgets.single_field_widget(
                                    "isolation distance (in Meters)",
                                    item.isolation_distance.toString(),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "have adequate storage facilities to handle the resultant seed?",
                                      item.have_adequate_storage_facility
                                          .toString(),
                                      is_yes_no: true),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have/has have adequate labor to carry out all farm operations in a timely manner?",
                                      item.have_adequate_labor.toString(),
                                      is_yes_no: true),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                    "Number of laborers",
                                    item.number_of_labors.toString(),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Aware that only seed that meets the minimum standards shall be accepted as certified seed?",
                                      item.aware_of_minimum_standards
                                          .toString(),
                                      is_yes_no: true),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Field", item.dealers_in.toString()),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: FxButton.outlined(
                                  borderRadiusAll: 0,
                                  onPressed: () {
                                    Utils.navigate_to(
                                        AppConfig.formQDSScreen, context);
                                    //showMyDialog(context);
                                  },
                                  child: FxText(
                                    "UPDATE MY CERTIFICATE",
                                    fontSize: 18,
                                    fontWeight: 800,
                                    color: CustomTheme.primary,
                                  ),
                                  borderColor: CustomTheme.primary,
                                ),
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: 60,
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
                child: FxButton.block(
                    borderRadiusAll: 0,
                    onPressed: () {
                      Utils.showSnackBar("Coming soon...", context);
                      //showMyDialog(context);
                    },
                    backgroundColor: CustomTheme.primary,
                    child: FxText(
                      "PRINT CERTIFICATE",
                      fontSize: 18,
                      fontWeight: 800,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        )),
      );
    });
  }
}
