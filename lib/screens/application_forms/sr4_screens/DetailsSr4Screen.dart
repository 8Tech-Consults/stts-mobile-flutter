import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_config.dart';
import '../../../utils/Utils.dart';

import '../../../models/FormSr4Model.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../widgets/my_widgets.dart';

class DetailsSr4Screen extends StatefulWidget {
  @override
  State<DetailsSr4Screen> createState() => DetailsSr4ScreenState();
}

late CustomTheme customTheme;

class DetailsSr4ScreenState extends State<DetailsSr4Screen> {
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

  List<FormSr4Model> sr4s = [];
  FormSr4Model item = new FormSr4Model();

  Future<Null> _do_refresh() async {
    return await _onRefresh(context);
  }

  Future<Null> _onRefresh(BuildContext _context) async {
    sr4s = await FormSr4Model.get_items();
    if (sr4s.isEmpty) {
      sr4s = await FormSr4Model.get_items();
    }
    if (sr4s.isEmpty) {
      Utils.showSnackBar("You have not SR4 certificate", context);
      Navigator.pop(context);
      return;
    }
    item = sr4s[(sr4s.length - 1)];
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
                    title: SizedBox(
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
                              "${item.type} CERTIFICATE".toUpperCase(),
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
                                  MyWidgets.single_field_widget("Experience in",
                                      item.expirience_in.toString())
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
                                  MyWidgets.single_field_widget(
                                      "Specialized in Crops",
                                      item.processing_of.toString())
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
                                  MyWidgets.single_field_widget("Marketing of",
                                      item.marketing_of.toString()),
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
                                      "Have/has adequate land to handle basic seed?",
                                      item.have_adequate_land.toString(),
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
                                      "Land size. (in Acres)",
                                      item.land_size.toString(),
                                      is_yes_no: false),
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
                                      "Have/has adequate equipment?",
                                      item.have_adequate_equipment.toString(),
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
                                      "Equipment", item.eqipment.toString(),
                                      is_yes_no: false),
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
                                      "Have/has adequate field officers?",
                                      item.have_adequate_field_officers
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
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have/has conversant seed matters?",
                                      item.have_conversant_seed_matters
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
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have/has adequate land for production?",
                                      item.have_adequate_land_for_production
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
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have/has internal quality program?",
                                      item.have_internal_quality_program
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
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  MyWidgets.single_field_widget(
                                      "Have/has adequate storage facilities to handle the resultant seed?",
                                      item.have_adequate_storage.toString(),
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
                                      "Source of seed",
                                      item.souce_of_seed.toString(),
                                      is_yes_no: false),
                                  MyWidgets.single_field_widget(
                                      "Seed board registration number",
                                      item.seed_board_registration_number
                                          .toString(),
                                      is_yes_no: false),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: FxButton.outlined(
                                  borderRadiusAll: 0,
                                  onPressed: () {
                                    Utils.navigate_to(
                                        AppConfig.formSr4Screen, context);
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
