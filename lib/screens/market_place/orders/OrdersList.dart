import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/market_controller.dart';
import 'package:STTS/models/order.dart';
import 'package:STTS/screens/market_place/orders/status_change_widget.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../models/OrderModel.dart';
import '../../../models/RespondModel.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/app_config.dart';

// ignore: must_be_immutable
class OrdersList extends StatefulWidget {
  final bool isMine;

  OrdersList({Key? key, required this.isMine}) : super(key: key);

  @override
  State<OrdersList> createState() => OrdersListState();
}

late CustomTheme customTheme;

class OrdersListState extends State<OrdersList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  MarketController marketController = MarketController();

  List<OrderModel> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    marketController.fetchOrders(locator<UserController>().user?.id,
        isMine: widget.isMine);
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
                widget.isMine ? 'My orders' : 'Incoming orders',
                style: const TextStyle(color: Colors.white),
              ),
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
                  : !model.isLoading && model.orders.isEmpty
                      ? const Center(
                          child: Text(
                            'No orders available',
                            style: TextStyle(color: Colors.red),
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
                                    return SingleProduct(
                                        model.orders[index], widget.isMine);
                                  },
                                  childCount:
                                      model.orders.length, // 1000 list items
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
    items = await OrderModel.get_items();

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(Order item, bool isMine) {
    return InkWell(
      onTap: () => {
        if (int.parse(item.status.toString()) != 6)
          {
            if (isMine && int.parse(item.status.toString()) == 3)
              {
                Get.to(
                  UpdateStatusWidget(
                    isMine: isMine,
                    order: item,
                    selectedOption: int.parse(item.status.toString()),
                  ),
                )
              }
            else if (!isMine)
              {
                Get.to(
                  UpdateStatusWidget(
                    isMine: isMine,
                    order: item,
                    selectedOption: item.status == "Pending"
                        ? 1
                        : int.parse(item.status.toString()),
                  ),
                )
              }
          }
      },
      child: Row(
        children: [
          Container(
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
                    "Order of ${item.quantity} Metric tonnes of ${item.cropVarietyText}",
                    fontSize: 20,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 10),
                  child: Utils.status_tell_widget(
                    item.status.toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> do_delete(int id) async {
    is_loading = true;
    setState(() {});
    String raw = await Utils.http_post('order/delete', {'id': id});
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
