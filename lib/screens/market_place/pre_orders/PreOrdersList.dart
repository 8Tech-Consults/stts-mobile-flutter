import 'package:STTS/controllers/market_controller.dart';
import 'package:STTS/models/order.dart';
import '../../../Constants/stts_uganda_exports.dart';
import '../../../models/PreOrderModel.dart';

// ignore: must_be_immutable
class PreOrdersList extends StatefulWidget {
  String title = "My Pre-Orders";

  PreOrdersList({Key? key}) : super(key: key);

  @override
  State<PreOrdersList> createState() => PreOrdersListState();
}

late CustomTheme customTheme;

class PreOrdersListState extends State<PreOrdersList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;
  MarketController marketController = MarketController();

  List<PreOrderModel> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    marketController.fetchPreOrders(locator<UserController>().user?.id);
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
      value: marketController,
      child: Consumer<MarketController>(
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
                        Utils.navigate_to(AppConfig.preOrderForm, context);
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
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return SingleProduct(model.preOrders[index]);
                                },
                                childCount:
                                    model.preOrders.length, // 1000 list items
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
    items = await PreOrderModel.get_items();

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(Order item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Utils.navigate_to(AppConfig.detailsScreen, context,
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
                    "Order of ${item.quantity} Metric tonnes of ${item.cropVarietyText}",
                    fontSize: 20,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(
                  height: 5,
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
                Utils.showConfirmDialog(context, () {
                  //onconfirm
                  // do_delete(item.id);
                }, () {
                  //on cancel
                },
                    message: "Are you sure you want to delete this Order?",
                    positive_text: "Delete");
              } else if (x == 1) {
                Utils.launchURL(
                    AppConfig.dashboardUrl + "/pre-orders/${item.id}");
              } else if (x == 3) {
                // Utils.navigate_to(AppConfig.detailsScreen, context,
                //     data: item.get_details());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 3,
                  child: FxText(
                    'View details',
                  )),
              // PopupMenuItem(value: 1, child: Text('View on web')), //done
              PopupMenuItem(
                  value: 0,
                  onTap: () {},
                  child: FxText(
                    'Delete',
                    color: Colors.red,
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
    String raw = await Utils.http_post('pre-order/delete', {'id': id});
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
