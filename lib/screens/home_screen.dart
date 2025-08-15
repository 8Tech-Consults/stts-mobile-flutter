import 'package:flutter/material.dart';

import '../../../utils/Utils.dart';
import '../controllers/user_controller.dart';
import '../injection_container.dart';
import '../models/LoggedInUserModel.dart';
import '../theme/app_theme.dart';
import '../theme/custom_theme.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'account/account_fragment.dart';
import 'home/home_fragment.dart';
import 'home/market_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late ThemeData theme;
  PageController? _pageController;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    Utils.init_theme();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButton: FloatingActionButton.extended(
          backgroundColor: MyColors.primary,
          elevation: 10,
          onPressed: () {
            Utils.navigate_to(AppConfig.LoginScreen, context);
            //Utils.navigate_to(AppConfig.TasksCreateScreen, context);
          },
          label: Row(
            children: [
              Icon(
                Icons.add,
                size: 18,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: FxText(
                  "Add Task",
                  fontWeight: 800,
                  color: Colors.white,
                ),
              ),
            ],
          )),*/
      backgroundColor: CustomTheme.bg_primary_light,
      body: SizedBox.expand(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            /*-------------- Build tab content here -----------------*/

            home_fragment(),
            MarketFragment(),
/*            NotificationScreen(),*/
            AccountFragment(
              root: context,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        animationDuration: Duration(milliseconds: 350),
        selectedItemOverlayColor: theme.colorScheme.primary.withAlpha(48),
        backgroundColor: theme.colorScheme.background,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <CustomBottomNavigationBarItem>[
          /*-------------- Build tabs here -----------------*/
          CustomBottomNavigationBarItem(
              title: 'Home',
              icon: Icon(Icons.home),
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
          CustomBottomNavigationBarItem(
            title: 'Market',
            icon: const Icon(Icons.shopping_cart),
            activeColor: theme.colorScheme.primary,
            inactiveColor: theme.colorScheme.onBackground.withAlpha(180),
          ),

          /*   CustomBottomNavigationBarItem(
              title: 'Alerts',
              icon: Icon(Icons.notifications),
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
*/
          CustomBottomNavigationBarItem(
              title: 'Account',
              icon: Icon(Icons.verified_user),
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
        ],
      ),
    );
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  LoggedInUserModel loggedInUserModel = new LoggedInUserModel();

  void get_logged_in_user() async {
    loggedInUserModel = await LoggedInUserModel.get_logged_in_user();
  }
}
