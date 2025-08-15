import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/injection_container.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../controllers/user_controller.dart';

class AccountFragment extends StatefulWidget {
  final BuildContext root;

  const AccountFragment({Key? key, required this.root}) : super(key: key);

  @override
  AccountFragmentState createState() => AccountFragmentState();
}

class AccountFragmentState extends State<AccountFragment> {
  UserController userController = UserController();

  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userController,
      child: Consumer<UserController>(
        builder: (_, model, child) {
          return Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 28),
                  height: 10,
                  color: Colors.black,
                ),
                Container(
                  height: 5,
                  color: Colors.yellow,
                ),
                Container(
                  height: 5,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 20,
                ),
                /*Column(
          children: <Widget>[
            FxContainer.rounded(
              paddingAll: 0,
              width: 100,
              height: 100,
              child: Image(
                  image: AssetImage("./assets/images/user.png"),
                  fit: BoxFit.fill),
            ),
            FxSpacing.height(8),
            FxText.sh1("${u.first_name} ${u.last_name}",
                fontWeight: 600, letterSpacing: 0),
          ],
        ),
        FxSpacing.height(24),*/
                FxContainer(
                  margin: FxSpacing.xy(20, 0),
                  color: Colors.red.shade800,
                  padding: FxSpacing.xy(16, 8),
                  borderRadiusAll: 4,
                  child: Row(
                    children: <Widget>[
                      Icon(MdiIcons.informationOutline,
                          color: theme.colorScheme.onPrimary, size: 18),
                      FxSpacing.width(16),
                      Expanded(
                        child: FxText(
                          "Logged in as",
                          fontWeight: 600,
                          letterSpacing: 0.2,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      FxSpacing.width(16),
                      FxText(
                        "${locator<UserController>().user?.name}",
                        color: FxColorUtils.goldColor,
                        fontWeight: 600,
                        letterSpacing: 0.2,
                      )
                    ],
                  ),
                ),
                FxSpacing.height(24),
                Column(
                  children: <Widget>[
                    singleOption(
                        iconData: MdiIcons.shapeOutline,
                        option: "Seed label",
                        screen: AppConfig.seedLabelList),
                    Container(
                      margin: FxSpacing.xy(20, 0),
                      child: Divider(
                        color: Colors.red.shade100,
                      ),
                    ),
                    singleOption(
                        iconData: MdiIcons.shapeOutline,
                        option: "Stock examination request",
                        screen: AppConfig.stockExaminationRequestList),
                    Container(
                      margin: FxSpacing.xy(20, 0),
                      child: Divider(
                        color: Colors.red.shade100,
                      ),
                    ),
                    singleOption(
                        iconData: MdiIcons.shapeOutline,
                        option: "Seed stock",
                        screen: AppConfig.seedStockList),
                    Container(
                      margin: FxSpacing.xy(20, 0),
                      child: Divider(
                        color: Colors.red.shade100,
                      ),
                    ),
                    singleOption(
                        iconData: MdiIcons.shoppingSearch,
                        option: "Incoming orders",
                        screen: AppConfig.incomingOrders),
                    Container(
                      margin: FxSpacing.xy(20, 0),
                      child: Divider(
                        color: Colors.red.shade100,
                      ),
                    ),
                    singleOption(
                        iconData: MdiIcons.contentPaste,
                        option: "My orders",
                        screen: AppConfig.myOrders),
                    Container(
                      margin: FxSpacing.xy(20, 0),
                      child: Divider(
                        color: Colors.red.shade100,
                      ),
                    ),
                    // singleOption(
                    //     iconData: MdiIcons.heartOutline,
                    //     option: "Pre-orders",
                    //     screen: AppConfig.preOrdersList),
                    // Container(
                    //   margin: FxSpacing.xy(20, 0),
                    //   child: Divider(
                    //     color: Colors.red.shade100,
                    //   ),
                    // ),
                    // singleOption(
                    //     iconData: MdiIcons.creditCardOutline,
                    //     option: "Quotation",
                    //     screen: AppConfig.quotationList),
                    // Container(
                    //   margin: FxSpacing.xy(20, 0),
                    //   child: Divider(
                    //     color: Colors.red.shade100,
                    //   ),
                    // ),
                    singleOption(
                        iconData: MdiIcons.qrcode,
                        option: "Track & Trace",
                        screen: AppConfig.trackScreen),
                    Container(
                      margin: FxSpacing.xy(20, 0),
                      child: Divider(
                        color: Colors.red.shade100,
                      ),
                    ),
                    // singleOption(
                    //     iconData: MdiIcons.web,
                    //     option: "Login to web dashboard",
                    //     screen: AppConfig.dashboardUrl),
                    // Container(
                    //   margin: FxSpacing.xy(20, 0),
                    //   child: Divider(
                    //     color: Colors.red.shade100,
                    //   ),
                    // ),
                    // singleOption(
                    //   iconData: MdiIcons.faceAgent,
                    //   option: "Help \& Support",
                    // ),
                    FxSpacing.height(24),
                    Center(
                      child: FxButton(
                        elevation: 0,
                        backgroundColor: theme.colorScheme.primary,
                        borderRadiusAll: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              MdiIcons.logoutVariant,
                              color: theme.colorScheme.onPrimary,
                              size: 18,
                            ),
                            FxSpacing.width(16),
                            FxText("LOGOUT",
                                letterSpacing: 0.3,
                                fontWeight: 600,
                                color: theme.colorScheme.onPrimary)
                          ],
                        ),
                        onPressed: () {
                          locator<UserController>().logOut();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget singleOption(
      {IconData? iconData, required String option, String screen = ""}) {
    return InkWell(
      onTap: () {
        if (AppConfig.dashboardUrl == screen) {
          Utils.launchURL(AppConfig.dashboardUrl);
          return;
        }

        Utils.navigate_to(screen, context);
      },
      child: Container(
        margin: FxSpacing.xy(20, 0),
        padding: FxSpacing.y(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 22,
              color: theme.colorScheme.onBackground,
            ),
            FxSpacing.width(16),
            Expanded(
              child: FxText(
                option,
                fontWeight: 600,
                color: MyColors.grey_95,
              ),
            ),
            Icon(MdiIcons.chevronRight,
                size: 22, color: theme.colorScheme.onBackground),
          ],
        ),
      ),
    );
  }
}
