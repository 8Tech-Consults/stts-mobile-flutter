import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/CropDeclarationModel.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:STTS/widgets/crop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../models/RespondModel.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/app_config.dart';
import '../../../widgets/my_widgets.dart';

// ignore: must_be_immutable
class CropDeclarationList extends StatefulWidget {
  String title = "My crop declaration forms";

  CropDeclarationList({Key? key}) : super(key: key);

  @override
  State<CropDeclarationList> createState() => CropDeclarationListState();
}

late CustomTheme customTheme;

class CropDeclarationListState extends State<CropDeclarationList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;
  PlantingController plantingController = PlantingController();

  List<CropDeclarationModel> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    plantingController
        .fetchCropDeclarations(locator<UserController>().user?.id);
  }

  void dipose() {
    pageController.dispose();
  }

  // ignore: non_constant_identifier_names
  bool is_loading = false;

  Future<void> _onRefresh(BuildContext _context) async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: plantingController,
      child: Consumer<PlantingController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CustomTheme.primary,
              elevation: .5,
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: Text(
                widget.title,
                style: const TextStyle(color: MyColors.grey_10),
              ),
              actions: [
                if (locator<UserController>().user?.roles[0].name ==
                    "Basic User")
                  InkWell(
                      onTap: () {
                        setState(() {
                          Utils.navigate_to(
                              AppConfig.cropDeclarationForm, context);
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          )))
              ],
            ),
            body: SafeArea(
                child: model.isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _do_refresh,
                        color: CustomTheme.primary,
                        backgroundColor: Colors.white,
                        child: model.cropDeclarations.isEmpty
                            ? MyWidgets.my_empty_widget(context,
                                'You have not created any crop declaration form. Press the "+" button in top right conner to create one.')
                            : CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return CropWidget(
                                          item: model.cropDeclarations[index],
                                        );
                                      },
                                      childCount: model.cropDeclarations
                                          .length, // 1000 list items
                                    ),
                                  )
                                ],
                              ),
                      )),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _do_refresh() async {
    is_loading = true;
    setState(() {});
    items = await CropDeclarationModel.get_items();

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(CropDeclarationModel item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Utils.navigate_to(AppConfig.detailsScreen, context,
                data: item.get_details());
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "${item.created_at}",
                    fontSize: 20,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Utils.tell_status_widget(item.status),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> do_delete(int id) async {
    is_loading = true;
    setState(() {});
    String raw =
        await Utils.http_post('qds-crop-declarations/delete', {'id': id});
    RespondModel resp = RespondModel(raw);

    is_loading = false;
    setState(() {});

    if (resp.code == 1) {
      Utils.showSnackBar(resp.message, context,
          color: Colors.white, background_color: Colors.green.shade600);
      _do_refresh();
    } else {
      Utils.showSnackBar(resp.message, context,
          color: Colors.white, background_color: Colors.red.shade600);
    }
  }
}
