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
// import '../../theme/custom_theme.dart';

class home_fragment extends StatefulWidget {
  @override
  State<home_fragment> createState() => home_fragmentState();
}

late CustomTheme customTheme;

class home_fragmentState extends State<home_fragment> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    locator<UserController>().init();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _do_refresh();
  }

  @override
  void dipose() {
    pageController.dispose();
  }

  List<MenuItem1> items = [];

  Future<Null> _onRefresh(BuildContext _context) async {
    items.clear();
    items.add(
      MenuItem1(
        "Import permit",
        'Import permit',
        '1',
        '1',
        AppConfig.importPermitList,
        ["", ""],
      ),
    );

    /*items.add(new MenuItem1(
        "Import permit", 'Import permit', '1', '1', AppConfig.ImportPermitForm));*/

    items.add(
      MenuItem1(
        "Export permit",
        'Seed grower',
        '1',
        '1',
        AppConfig.exportPermitList,
        ["", ""],
      ),
    );

    items.add(
      MenuItem1(
        "Planting return",
        'Individual',
        '1',
        '1',
        AppConfig.plantingRetunList,
        ["Inspector", "Basic User"],
      ),
    );
    /*    items.add(new MenuItem1("Company Planting returns", 'Company', '1', '1',
        AppConfig.CompanyPlantingReturnForm));*/

    items.add(
      MenuItem1(
        "Planting inspection",
        'SR10',
        '1',
        '1',
        AppConfig.plantingInspectionList,
        ["Inspector", "Basic User"],
      ),
    );

    items.add(
      MenuItem1(
        "QDS Crop declarations",
        'QDS',
        '1',
        '1',
        AppConfig.cropDeclarationList,
        ["Basic User", "Inspector"],
      ),
    );
    items.add(
      MenuItem1(
        "QDS Crop Inspection",
        'QDS',
        '1',
        '1',
        AppConfig.cropInspectionList,
        ["Inspector"],
      ),
    );

    items.add(
      MenuItem1("Seed lab", 'Seed Lab', '1', '1', AppConfig.seedLabList, [
        "lab-technician",
        "Basic User",
        "Inspector",
        "Lab technician",
      ]),
    );
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return Scaffold(
          body: FutureBuilder(
            future: Future.delayed(const Duration(microseconds: 3)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? SafeArea(
                    child: RefreshIndicator(
                      onRefresh: _do_refresh,
                      color: CustomTheme.primary,
                      backgroundColor: Colors.white,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: CustomTheme.primary,
                            toolbarHeight: 90,
                            titleSpacing: 0,
                            title: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 20,
                                  ),
                                  child: FxText(
                                    AppConfig.appName,
                                    color: Colors.white,
                                    fontSize: 23,
                                    height: 1,
                                    fontWeight: 800,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 7),
                                  height: 5,
                                  color: Colors.black,
                                ),
                                Container(height: 5, color: Colors.yellow),
                                Container(height: 5, color: Colors.red),
                              ],
                            ),
                            floating: true,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    //Utils.navigate_to(AppConfig.OnBoardingScreen, context);
                                    //Utils.boot_system();
                                  },
                                  child: FxContainer(
                                    borderRadiusAll: 0,
                                    marginAll: 0,
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    color: CustomTheme.bg_primary_light,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (locator<UserController>()
                                                .user
                                                ?.roles[0]
                                                .name ==
                                            "Basic User")
                                          FxText(
                                            "Application forms",
                                            fontSize: 24,
                                            fontWeight: 900,
                                            color: Colors.black,
                                          ),
                                        if (locator<UserController>()
                                                .user
                                                ?.roles[0]
                                                .name ==
                                            "Basic User")
                                          const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 1, // 1000 list items
                            ),
                          ),
                          if (locator<UserController>().user?.roles[0].name ==
                              "Basic User")
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      Image(
                                        width: double.infinity,
                                        height:
                                            (Utils.screen_height(context) /
                                            1.6),
                                        fit: BoxFit.cover,
                                        image: const AssetImage(
                                          "assets/images/bg-1.jpeg",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 35),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Utils.navigate_to(
                                                    AppConfig.formSr4SList,
                                                    context,
                                                  );
                                                },
                                                child: FxCard(
                                                  color: Colors.black,
                                                  paddingAll: 5,
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FxText(
                                                        "SR4",
                                                        color: Colors.white,
                                                        fontWeight: 800,
                                                        fontSize: 30,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      FxText(
                                                        "Become a certified Seed Merchant, Producer, Stockist, Importer, Exporter or Processor.",
                                                        color: Colors.white,
                                                        fontWeight: 600,
                                                        fontSize: 10,
                                                      ),
                                                      FxContainer(
                                                        margin:
                                                            const EdgeInsets.only(
                                                              left: 0,
                                                              bottom: 10,
                                                              right: 0,
                                                              top: 10,
                                                            ),
                                                        padding:
                                                            const EdgeInsets.only(
                                                              left: 5,
                                                              bottom: 2,
                                                              right: 5,
                                                              top: 2,
                                                            ),
                                                        child: Row(
                                                          children: [
                                                            FxText(
                                                              (sr4s.isNotEmpty)
                                                                  ? "View my SR4"
                                                                  : "Apply now",
                                                              fontSize:
                                                                  (sr4s
                                                                      .isNotEmpty)
                                                                  ? 11
                                                                  : 12,
                                                              fontWeight: 700,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              size: 14,
                                                            ),
                                                          ],
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        ),
                                                        
                                                      ),
                                                    ],
                                                  ),
                                                  
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Utils.navigate_to(
                                                    AppConfig.formSr6Screen,
                                                    context,
                                                  );
                                                },
                                                child: InkWell(
                                                  onTap: () => {
                                                    sr6s.isEmpty
                                                        ? Utils.navigate_to(
                                                            AppConfig
                                                                .formSr6SList,
                                                            context,
                                                          )
                                                        : Utils.navigate_to(
                                                            AppConfig
                                                                .formSr6SList,
                                                            context,
                                                          ),
                                                  },
                                                  child: FxCard(
                                                    color:
                                                        Colors.yellow.shade800,
                                                    paddingAll: 5,
                                                    width: double.infinity,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        FxText(
                                                          "SR6",
                                                          color: Colors.black,
                                                          fontWeight: 800,
                                                          fontSize: 30,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        FxText(
                                                          "Become a certified Seed grower, Seed Company or Seed Breeders",
                                                          color: Colors.black,
                                                          fontWeight: 600,
                                                          fontSize: 10,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        FxContainer(
                                                          child: Row(
                                                            children: [
                                                              FxText(
                                                                (!sr6s.isEmpty)
                                                                    ? "View my SR6"
                                                                    : "Apply now",
                                                                fontSize: 11,
                                                                fontWeight: 700,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .chevron_right,
                                                                size: 15,
                                                              ),
                                                            ],
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                          ),
                                                          margin:
                                                              const EdgeInsets.only(
                                                                left: 0,
                                                                bottom: 10,
                                                                right: 0,
                                                                top: 10,
                                                              ),
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 5,
                                                                bottom: 2,
                                                                right: 5,
                                                                top: 2,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  qds.isEmpty
                                                      ? Utils.navigate_to(
                                                          AppConfig.formQDSList,
                                                          context,
                                                        )
                                                      : Utils.navigate_to(
                                                          AppConfig.formQDSList,
                                                          context,
                                                        );
                                                },
                                                child: FxCard(
                                                  color: Colors.red.shade800,
                                                  paddingAll: 5,
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FxText(
                                                        "QDS",
                                                        color: Colors.white,
                                                        fontWeight: 800,
                                                        fontSize: 30,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      FxText(
                                                        "Become a certified Quality Declared Seed producer.",
                                                        color: Colors.white,
                                                        fontWeight: 600,
                                                        fontSize: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      FxContainer(
                                                        
                                                        margin:
                                                            const EdgeInsets.only(
                                                              left: 0,
                                                              bottom: 10,
                                                              right: 0,
                                                              top: 10,
                                                            ),
                                                        padding:
                                                            const EdgeInsets.only(
                                                              left: 5,
                                                              bottom: 2,
                                                              right: 5,
                                                              top: 2,
                                                            ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            FxText(
                                                              qds.isEmpty
                                                                  ? "Apply now"
                                                                  : "View QDS",
                                                              fontSize: 12,
                                                              fontWeight: 700,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              size: 15,
                                                            ),
                                                          ],
                                                          
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                childCount: 1, // 1000 list items
                              ),
                            ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    //Utils.navigate_to(AppConfig.OnBoardingScreen, context);
                                    //Utils.boot_system();
                                  },
                                  child: FxContainer(
                                    borderRadiusAll: 0,
                                    marginAll: 0,
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    color: CustomTheme.bg_primary_light,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => {_onRefresh},
                                          child: FxText(
                                            "Quality Assurance",
                                            fontSize: 24,
                                            fontWeight: 900,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.verified_outlined,
                                          color: Colors.blue,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 1, // 1000 list items
                            ),
                          ),
                          if (locator<UserController>().user?.roles[0].name !=
                              null)
                            SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  var filterRoles = items
                                      .where(
                                        (i) => i.roles.contains(
                                          locator<UserController>()
                                              .user
                                              ?.roles[0]
                                              .name,
                                        ),
                                      )
                                      .toList();
                                  return SingleMenuItem(filterRoles[index]);
                                },
                                childCount: items
                                    .where(
                                      (i) => i.roles.contains(
                                        locator<UserController>()
                                            .user
                                            ?.roles[0]
                                            .name,
                                      ),
                                    )
                                    .toList()
                                    .length,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  List<FormSr4Model> sr4s = [];
  List<FormSr6Model> sr6s = [];
  List<QDSModel> qds = [];

  Future<Null> _do_refresh() async {
    // sr4s = await FormSr4Model.get_items();
    // sr6s = await FormSr6Model.get_items();
    // qds = await QDSModel.get_items();
    return await _onRefresh(context);
  }

  SingleMenuItem(MenuItem1 item) {
    //seeds_bg_2.png
    return InkWell(
      onTap: () {
        Utils.navigate_to(item.action_screen, context);
      },
      child: FxContainer(
        borderRadiusAll: 0,
        marginAll: 0,
        paddingAll: 5,
        color: CustomTheme.bg_primary_light,
        child: Stack(
          children: [
            Image(
              width: double.infinity,
              height: (Utils.screen_height(context) / 1.5),
              fit: BoxFit.cover,
              image: AssetImage("assets/images/seeds_bg_1.png"),
            ),
            FxContainer(
              marginAll: 0,
              paddingAll: 5,
              color: Colors.transparent,
              bordered: true,
              border: Border.all(color: Colors.transparent, width: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                        Icon(
                          Icons.verified_outlined,
                          color: Colors.red,
                          size: 20,
                        ),
                        FxText(
                          "",
                          fontSize: 16,
                          fontWeight: 400,
                          color: Colors.white,
                        ),
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
                  const Spacer(),
                  FxContainer(
                    color: Colors.yellow.shade800,
                    marginAll: 0,
                    
                    margin: EdgeInsets.only(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      top: 10,
                    ),
                    padding: EdgeInsets.only(
                      left: 10,
                      bottom: 2,
                      right: 5,
                      top: 2,
                    ),
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText(
                          "View all",
                          fontSize: 12,
                          fontWeight: 700,
                          color: Colors.black,
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 15,
                          color: Colors.black,
                        ),
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

  /*

  SingleMenuItem(MenuItem1 item) {
    return ListTile(
      title: FxText.h3(item.title, fontWeight: 400, fontSize: 20),
      onTap: () {
        Utils.init_theme();
        //Utils.navigate_to(item.action_screen, context);
      },
    );
  }*/

  Future<void> pick_location(OptionPickerModel item) async {
    List<OptionPickerModel> next_items = [];
  }
}
