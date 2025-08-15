import 'package:STTS/controllers/seed_controller.dart';
import 'package:STTS/controllers/user_controller.dart';
import 'package:STTS/injection_container.dart';
import 'package:STTS/models/StockModel.dart';
import 'package:STTS/models/seed_stock.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/app_config.dart';

// ignore: must_be_immutable
class SeedStockList extends StatefulWidget {
  String title = "My Seed stock";

  SeedStockList({Key? key}) : super(key: key);

  @override
  State<SeedStockList> createState() => SeedStockListState();
}

late CustomTheme customTheme;

class SeedStockListState extends State<SeedStockList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  SeedController seedController = SeedController();

  List<StockModel> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    seedController.fetchSeedStocks(locator<UserController>().user?.id);
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
      value: seedController,
      child: Consumer<SeedController>(
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
                                  return SingleProduct(model.seedStocks[index]);
                                },
                                childCount:
                                    model.seedStocks.length, // 1000 list items
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
    items = await StockModel.get_items();

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(SeedStock item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Utils.navigate_to(AppConfig.detailsScreen, context,
            //     data: item.get_details());
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
                    "Lot Number: ${item.seedId?.lotNumber}",
                    fontSize: 15,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "Quantity: ${item.seedId?.quantity} Kgs",
                    fontSize: 15,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
