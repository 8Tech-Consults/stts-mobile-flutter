/*
* File : Custom Onboarding
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_config.dart';
import '../../controllers/user_controller.dart';
import '../../theme/app_theme.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingWidgeScreen createState() => _OnBoardingWidgeScreen();
}

class _OnBoardingWidgeScreen extends State<OnBoardingScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    myDelay();
  }

  Future<void> myDelay() async {
    await Future.delayed(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: CustomTheme.primary.withAlpha(40))),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: ((MediaQuery.of(context).size.height / 2) - 200)),
                  child: Image.asset(
                    AppConfig.logo_1,
                    height: 170,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(
                      top: ((MediaQuery.of(context).size.height / 2) - 100)),
                  child: CircularProgressIndicator(
                    color: CustomTheme.primary,
                    backgroundColor: const Color.fromARGB(255, 16, 15, 15),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigateUser() async {
    if (context.read<UserController>().isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (r) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/LoginScreen", (r) => false);
    }
  }
}
