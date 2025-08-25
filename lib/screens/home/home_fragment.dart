import 'package:STTS/models/QDSModel.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../models/menu_item_1.dart';
import '../../controllers/user_controller.dart';
import '../../injection_container.dart';
import '../../utils/app_config.dart';
import '../../../utils/Utils.dart';
import '../../models/FormSr4Model.dart';
import '../../models/FormSr6Model.dart';
import '../../models/option_picker_model.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';

class home_fragment extends StatefulWidget {
  @override
  State<home_fragment> createState() => home_fragmentState();
}

late CustomTheme customTheme;

class home_fragmentState extends State<home_fragment> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  List<MenuItem1> items = [];
  List<FormSr4Model> sr4s = [];
  List<FormSr6Model> sr6s = [];
  List<QDSModel> qds = [];

  @override
  void initState() {
    super.initState();
    locator<UserController>().init();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _loadData();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// Centralized data load/refresh
  Future<void> _loadData() async {
    await _buildMenuItems();
    // Uncomment when hooking real data:
    // sr4s = await FormSr4Model.get_items();
    // sr6s = await FormSr6Model.get_items();
    // qds = await QDSModel.get_items();
    if (mounted) setState(() {});
  }

  Future<void> _onRefresh() async => _loadData();

  Future<void> _buildMenuItems() async {
    items = [];
    items.add(MenuItem1(
      "Import permit",
      'Import permit',
      '1',
      '1',
      AppConfig.importPermitList,
      ["", ""],
    ));

    items.add(MenuItem1(
      "Export permit",
      'Seed grower',
      '1',
      '1',
      AppConfig.exportPermitList,
      ["", ""],
    ));

    items.add(MenuItem1(
      "Planting return",
      'Individual',
      '1',
      '1',
      AppConfig.plantingRetunList,
      ["Inspector", "Basic User"],
    ));

    items.add(MenuItem1(
      "Planting inspection",
      'SR10',
      '1',
      '1',
      AppConfig.plantingInspectionList,
      ["Inspector", "Basic User"],
    ));

    items.add(MenuItem1(
      "QDS Crop declarations",
      'QDS',
      '1',
      '1',
      AppConfig.cropDeclarationList,
      ["Basic User", "Inspector"],
    ));

    items.add(MenuItem1(
      "QDS Crop Inspection",
      'QDS',
      '1',
      '1',
      AppConfig.cropInspectionList,
      ["Inspector"],
    ));

    items.add(MenuItem1(
      "Seed lab",
      'Seed Lab',
      '1',
      '1',
      AppConfig.seedLabList,
      [
        "lab-technician",
        "Basic User",
        "Inspector",
        "Lab technician",
      ],
    ));
  }

  // Breakpoint helper
  int _columnsForWidth(double w) {
    if (w >= 1200) return 4;
    if (w >= 900) return 3;
    if (w >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final roleName = (locator<UserController>().user?.roles.isNotEmpty ?? false)
        ? locator<UserController>().user!.roles[0].name
        : null;

    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: CustomTheme.primary,
              backgroundColor: Colors.white,
              child: CustomScrollView(
                slivers: [
                  // HEADER
                  SliverAppBar(
                    backgroundColor: CustomTheme.primary,
                    toolbarHeight: 90,
                    titleSpacing: 0,
                    floating: true,
                    title: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 20),
                          child: FxText(
                            AppConfig.appName,
                            color: Colors.white,
                            fontSize: 23,
                            height: 1,
                            fontWeight: 800,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 7), height: 5, color: Colors.black),
                        Container(height: 5, color: Colors.yellow),
                        Container(height: 5, color: Colors.red),
                      ],
                    ),
                  ),

                  // Application Forms headline (Basic User only)
                  if (roleName == "Basic User")
                    SliverToBoxAdapter(
                      child: InkWell(
                        onTap: () {},
                        child: FxContainer(
                          borderRadiusAll: 0,
                          marginAll: 0,
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          color: CustomTheme.bg_primary_light,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText(
                                "Application forms",
                                fontSize: 24,
                                fontWeight: 900,
                                color: Colors.black,
                              ),
                              Icon(Icons.edit, color: Colors.blue, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Hero image + responsive cards (SR4, SR6, QDS)
                  if (roleName == "Basic User")
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          // Responsive hero image
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.asset(
                              "assets/images/bg-1.jpeg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          // Overlay grid
                          Padding(
                            padding: EdgeInsets.only(top: 35, left: 10, right: 10),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final cols = _columnsForWidth(constraints.maxWidth);
                                final cards = <Widget>[
                                  _SR4Card(
                                    hasItems: sr4s.isNotEmpty,
                                    onTap: () => Utils.navigate_to(AppConfig.formSr4SList, context),
                                  ),
                                  _SR6Card(
                                    hasItems: sr6s.isNotEmpty,
                                    onTap: () => Utils.navigate_to(AppConfig.formSr6SList, context),
                                  ),
                                  _QDSCard(
                                    hasItems: qds.isNotEmpty,
                                    onTap: () => Utils.navigate_to(AppConfig.formQDSList, context),
                                  ),
                                ];

                                return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cards.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: cols,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.5, // adjust to taste
                                  ),
                                  itemBuilder: (_, i) => cards[i],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Quality Assurance row
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: _onRefresh, // actually calls refresh now
                      child: FxContainer(
                        borderRadiusAll: 0,
                        marginAll: 0,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        color: CustomTheme.bg_primary_light,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxText(
                              "Quality Assurance",
                              fontSize: 24,
                              fontWeight: 900,
                              color: Colors.black,
                            ),
                            Icon(Icons.verified_outlined, color: Colors.blue, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Role-filtered menu items as a responsive grid
                  if (roleName != null)
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300, // tile width cap → auto columns
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final filterRoles = items
                              .where((i) => i.roles.contains(roleName))
                              .toList();
                          return SingleMenuItem(filterRoles[index]);
                        },
                        childCount: items.where((i) => i.roles.contains(roleName)).length,
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

  // Single menu tile
  Widget SingleMenuItem(MenuItem1 item) {
    return InkWell(
      onTap: () => Utils.navigate_to(item.action_screen, context),
      child: FxContainer(
        borderRadiusAll: 0,
        marginAll: 0,
        paddingAll: 5,
        color: CustomTheme.bg_primary_light,
        child: Stack(
          children: [
            // Responsive background art (no fixed height)
            AspectRatio(
              aspectRatio: 3 / 2, // tweak as desired
              child: Image.asset(
                "assets/images/seeds_bg_1.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            // Foreground content
            FxContainer(
              marginAll: 0,
              paddingAll: 5,
              color: Colors.transparent,
              bordered: true,
              border: Border.all(color: Colors.transparent, width: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxContainer(
                    borderRadiusAll: 0,
                    margin: EdgeInsets.only(bottom: 10),
                    paddingAll: 0,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.verified_outlined, color: Colors.red, size: 20),
                        FxText("", fontSize: 16, fontWeight: 400, color: Colors.white),
                      ],
                    ),
                  ),
                  FxText(
                    item.title,
                    textAlign: TextAlign.start,
                    color: Colors.grey.shade100,
                    fontSize: 16,
                    height: 1.01,
                    fontWeight: 800,
                  ),
                  Spacer(),
                  FxContainer(
                    color: Colors.yellow.shade800,
                    marginAll: 0,
                    padding: EdgeInsets.only(left: 10, bottom: 2, right: 5, top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText("View all", fontSize: 12, fontWeight: 700, color: Colors.black),
                        Icon(Icons.chevron_right, size: 15, color: Colors.black),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pick_location(OptionPickerModel item) async {
    // future expansion
  }
}

/// SR4 card
class _SR4Card extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasItems;
  const _SR4Card({required this.onTap, required this.hasItems});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FxCard(
        color: Colors.black,
        paddingAll: 4,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText("SR4", color: Colors.white, fontWeight: 800, fontSize: 30),
            SizedBox(height: 6),
            // Downscale gracefully on small screens
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: FxText(
                "Become a certified Seed Merchant, Producer, Stockist, Importer, Exporter or Processor.",
                color: Colors.white,
                fontWeight: 600,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            FxContainer(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText(hasItems ? "View my SR4" : "Apply now", fontSize: 12, fontWeight: 700),
                  Icon(Icons.chevron_right, size: 15, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// SR6 card
class _SR6Card extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasItems;
  const _SR6Card({required this.onTap, required this.hasItems});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FxCard(
        color: Colors.yellow.shade800,
        paddingAll: 8,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText("SR6", color: Colors.black, fontWeight: 800, fontSize: 30),
            SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: FxText(
                "Become a certified Seed grower, Seed Company or Seed Breeders",
                color: Colors.black,
                fontWeight: 600,
                fontSize: 12,
              ),
            ),
             SizedBox(height: 10),
            FxContainer(
              padding:  EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText(hasItems ? "View my SR6" : "Apply now", fontSize: 12, fontWeight: 700),
                   Icon(Icons.chevron_right, size: 15, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// QDS card
class _QDSCard extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasItems;
  const _QDSCard({required this.onTap, required this.hasItems});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FxCard(
        color: Colors.red.shade800,
        paddingAll: 8,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText("QDS", color: Colors.white, fontWeight: 800, fontSize: 30),
            SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: FxText(
                "Become a certified Quality Declared Seed producer.",
                color: Colors.white,
                fontWeight: 600,
                fontSize: 12,
              ),
            ),
             SizedBox(height: 10),
            FxContainer(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText(hasItems ? "View QDS" : "Apply now", fontSize: 12, fontWeight: 700),
                  Icon(Icons.chevron_right, size: 15, color: Colors.white,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
