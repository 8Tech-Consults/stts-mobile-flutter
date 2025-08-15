import 'package:STTS/controllers/srform_controller.dart';
import 'package:STTS/models/FormSr4Model.dart';
import 'package:STTS/models/Sr4Model.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:STTS/widgets/my_widgets.dart';
import 'package:STTS/widgets/sr_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../Constants/stts_uganda_exports.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/app_config.dart';

// ignore: must_be_immutable
class FormSr4SList extends StatefulWidget {
  String title = "My SR4 forms";

  FormSr4SList({Key? key}) : super(key: key);

  @override
  State<FormSr4SList> createState() => FormSr4SListState();
}

late CustomTheme customTheme;

class FormSr4SListState extends State<FormSr4SList> {
  final PageController pageController = PageController(initialPage: 0);
  SrFormController srFormController = SrFormController();
  late ThemeData theme;

  List<FormSr4Model> items = [];

  @override
  void initState() {
    super.initState();
    srFormController.init(locator<UserController>().user?.id);
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
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
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                InkWell(
                    onTap: () {
                      setState(() {
                        Utils.navigate_to(AppConfig.formSr4Screen, context);
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
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _do_refresh,
                      color: CustomTheme.primary,
                      backgroundColor: Colors.white,
                      child: model.sr4Models.isEmpty
                          ? MyWidgets.my_empty_widget(context,
                              'You have not created any SR4. Press the "+" button in top right conner to create one.')
                          : CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      var data = model.sr4Models[index];
                                      return SrWidget(
                                        item: data,
                                      );
                                    },
                                    childCount: model
                                        .sr4Models.length, // 1000 list items
                                  ),
                                )
                              ],
                            ),
                    ),
            ),
          );
        },
      ),
    );
  }

// ignore: non_constant_identifier_names
  Future<void> _do_refresh() async {
    is_loading = true;
    setState(() {});
    items = await FormSr4Model.get_items();

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

// ignore: non_constant_identifier_names
  SingleProduct(SrModel item, size) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Utils.navigate_to(AppConfig.DetailsScreen, context,
            //     data: item.get_details());
          },
          child: Container(
            width: (size.width - 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.nameOfApplicant != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            const Text('Name of applicant:'),
                            const SizedBox(
                              width: 10,
                            ),
                            FxText(
                              "${item.nameOfApplicant}",
                              fontSize: 20,
                              height: 1.1,
                              color: Colors.grey.shade900,
                            ),
                          ],
                        )),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Text('Type:'),
                          const SizedBox(
                            width: 10,
                          ),
                          FxText(
                            "${item.type}",
                            fontSize: 20,
                            height: 1.1,
                            color: Colors.grey.shade900,
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Row(
                    children: [
                      const Text('Status:'),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, top: 0),
                        child: Utils.tell_status_widget(
                          item.status.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Text('Date:'),
                          const SizedBox(
                            width: 10,
                          ),
                          FxText(
                            "${item.createdAt}",
                            fontSize: 15,
                            height: 1.1,
                            color: Colors.grey.shade900,
                          ),
                        ],
                      )),
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
                //   // do_delete(item.id);
                // }, () {
                //   //on cancel
                // },
                //     message: "Are you sure you want to delete this form?",
                //     positive_text: "Delete");
              } else if (x == 1) {
                // Utils.launchURL(
                //     AppConfig.DASHBOARD_URL + "/form-sr4s/${item.id}");
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
              const PopupMenuItem(value: 1, child: Text('View on web')), //done
              PopupMenuItem(
                  enabled: Utils.is_deletable(item.status.toString()),
                  value: 0,
                  onTap: () {
                    print("romina");
                  },
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

// Future<void> do_delete(int id) async {
//   is_loading = true;
//   setState(() {});
//   String raw = await Utils.http_post('forms/sr4/delete', {'id': id});
//   RespondModel resp = RespondModel(raw);

//   is_loading = false;
//   setState(() {});

//   if (resp.code == 1) {
//     Utils.showSnackBar(resp.message, context,
//         color: Colors.white, background_color: Colors.green.shade600);
//     _do_refresh();
//   } else {
//     Utils.showSnackBar(resp.message, context,
//         color: Colors.white, background_color: Colors.red.shade600);
//   }
// }
}
