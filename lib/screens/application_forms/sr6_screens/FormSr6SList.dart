import 'package:STTS/controllers/srform_controller.dart';
import 'package:STTS/controllers/user_controller.dart';
import 'package:STTS/injection_container.dart';
import 'package:STTS/models/FormSr6Model.dart';
import 'package:STTS/models/Sr4Model.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:STTS/widgets/sr_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../models/FormSr6Model.dart';
import '../../../models/RespondModel.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/app_config.dart';
import '../../../widgets/my_widgets.dart';

// ignore: must_be_immutable
class FormSr6SList extends StatefulWidget {
  String title = "My SR6 forms";

  FormSr6SList({Key? key}) : super(key: key);

  @override
  State<FormSr6SList> createState() => FormSr6SListState();
}

late CustomTheme customTheme;

class FormSr6SListState extends State<FormSr6SList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  SrFormController srFormController = SrFormController();

  List<FormSr6Model> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    srFormController.fetchSr6Forms(locator<UserController>().user?.id);
    //_do_refresh();
  }

  void dipose() {
    pageController.dispose();
  }

  // ignore: non_constant_identifier_names
  bool is_loading = false;

  Future<void> _onRefresh(BuildContext _context) async {
    is_loading = true;
    setState(() {});

    return;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: srFormController,
      child: Consumer<SrFormController>(
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
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      setState(() {
                        Utils.navigate_to(AppConfig.formSr6Screen, context);
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
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _do_refresh,
                        color: CustomTheme.primary,
                        backgroundColor: Colors.white,
                        child: model.sr6Models.isEmpty && !model.isLoading
                            ? MyWidgets.my_empty_widget(context,
                                'You have not created any SR6. Press the "+" button in top right conner to create one.')
                            : CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        var data = model.sr6Models[index];
                                        return SrWidget(
                                          item: data,
                                        );
                                      },
                                      childCount: model
                                          .sr6Models.length, // 1000 list items
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
    items = await FormSr6Model.get_items();

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(SrModel item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Utils.navigate_to(AppConfig.DetailsScreen, context,
            //     data: item.get_details());
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 50),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "${item.type}",
                    fontSize: 20,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Utils.tell_status_widget(item.status.toString()),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: PopupMenuButton<int>(
            onSelected: (x) {
              if (x == 0) {
                // Utils.showConfirmDialog(context, () {
                //   //onconfirm
                //   do_delete(item.id);
                // }, () {
                //   //on cancel
                // },
                //     message: "Are you sure you want to delete this form?",
                //     positive_text: "Delete");
              } else if (x == 1) {
                // Utils.launchURL(
                //     AppConfig.DASHBOARD_URL + "/form-sr6/${item.id}");
              } else if (x == 3) {
                // Utils.navigate_to(AppConfig.DetailsScreen, context,
                //     data: item.get_details());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 3,
                  child: FxText(
                    'View details',
                  )),
              PopupMenuItem(value: 1, child: Text('View on web')), //done
              PopupMenuItem(
                  enabled: Utils.is_deletable(item.status.toString()),
                  value: 0,
                  onTap: () {},
                  child: FxText(
                    'Delete',
                    color: (!Utils.is_deletable(item.status.toString()))
                        ? Colors.grey.shade300
                        : Colors.red,
                  )),
            ],
          ),
        )
      ],
    );
  }

  Future<void> do_delete(int id) async {
    is_loading = true;
    setState(() {});
    String raw = await Utils.http_post('forms/sr6/delete', {'id': id});
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
