import 'dart:developer';

import 'package:STTS/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutx/themes/app_theme_notifier.dart';
import 'package:provider/provider.dart';

import '../../../screens/account/login_screen.dart';
import '../../../screens/account/onboarding_widget.dart';
import '../../../screens/home_screen.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/Utils.dart';
import 'controllers/home_controller.dart';
import 'controllers/user_controller.dart';

//I love romina
//FROM DISK D
// keytool -list -keystore 'stts.jks'
// Abertnamanya2.
//net.eighttechnologes.stts
// flutter pub run change_app_package_name:main net.eighttechnologes.stts

void main() {
  initializeDependencies();

  //You will need to initialize AppThemeNotifier class for theme changes.
  WidgetsFlutterBinding.ensureInitialized();
  Utils.boot_system();
  AppTheme.init();


  log("🚀 App started");
  //
  // Utils.init_databse();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<AppNotifier>(
      create: (context) => AppNotifier(),
      child: const MyApp(),
      // child: ChangeNotifierProvider<FxAppThemeNotifier>(
      //   create: (context) => FxAppThemeNotifier(),
      //   child: MyApp(),
      // ),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserController userController = UserController();
  HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    userController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: userController),
            ChangeNotifierProvider(create: (_) => HomeController()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            builder: (context, child) {
              return Directionality(
                textDirection: AppTheme.textDirection,
                child: child!,
              );
            },
            home: OnBoardingScreen(),
            routes: {
              '/OnBoardingWidget': (context) => OnBoardingScreen(),
              '/HomeScreen': (context) => HomeScreen(),
              '/LoginScreen': (context) => LoginScreen(),
            },
          ),
        );
      },
    );
  }
}

class GlobalMaterialLocalizations {}
