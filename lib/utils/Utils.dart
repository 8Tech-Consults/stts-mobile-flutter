import 'dart:convert';
import 'dart:io';

import 'package:STTS/screens/Scan/Scanning/scan.dart';

import 'package:STTS/screens/quality_assurance/company_planting_return/CompanyPlantingReturnForm.dart';
import 'package:STTS/screens/quality_assurance/sr10planting_inspection/cropInspectionList.dart';
import 'package:STTS/screens/seed_stock/seed_stock/StockExaminationUpdate.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/adapter.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/CropVarietyModel.dart';
import '../../../models/CropsModel.dart';
import '../../../models/SeedLabelModel.dart';
import '../../../screens/application_forms/qds_screens/DetailsFormQDSScreen.dart';
import '../../../screens/home_screen.dart';
import '../../../screens/quality_assurance/seed_lab/SeedLabForm.dart';
import '../../../theme/app_theme.dart';
import '../models/DynamicTable.dart';
import '../models/FormSr6Model.dart';
import '../models/LoggedInUserModel.dart';
import '../models/QDSModel.dart';
import '../models/SeedLabelPackageModel.dart';
import '../models/user.dart';
import '../screens/account/login_screen.dart';
import '../screens/account/onboarding_widget.dart';
import '../screens/account/register_screen.dart';
import '../screens/application_forms/qds_screens/DetailsFormQDSScreen.dart';
import '../screens/application_forms/qds_screens/FormQDSList.dart';
import '../screens/application_forms/qds_screens/FormQDSScreen.dart';
import '../screens/application_forms/sr4_screens/DetailsSr4Screen.dart';
import '../screens/application_forms/sr4_screens/FormSr4SList.dart';
import '../screens/application_forms/sr4_screens/FormSr4Screen.dart';
import '../screens/application_forms/sr6_screens/DetailsSr6Screen.dart';
import '../screens/application_forms/sr6_screens/FormSr6SList.dart';
import '../screens/application_forms/sr6_screens/FormSr6Screen.dart';
import '../screens/market_place/orders/OrdersList.dart';
import '../screens/market_place/pre_orders/PreOrderForm.dart';
import '../screens/market_place/pre_orders/PreOrdersList.dart';
import '../screens/market_place/quotations/QuotationList.dart';
import '../screens/quality_assurance/export_permit/ExportPermitForm.dart';
import '../screens/quality_assurance/export_permit/ExportPermitList.dart';
import '../screens/quality_assurance/importPermit/ImportPermitForm.dart';
import '../screens/quality_assurance/importPermit/ImportPermitList.dart';
import '../screens/quality_assurance/planting_return/IndividualPlantingReturnForm.dart';
import '../screens/quality_assurance/planting_return/PlantingRetunList.dart';
import '../screens/quality_assurance/qds_crop_declaration/CropDeclarationForm.dart';
import '../screens/quality_assurance/qds_crop_declaration/CropDeclarationList.dart';
import '../screens/quality_assurance/seed_lab/SeedLabList.dart';
import '../screens/quality_assurance/seed_labels/seed_label_form.dart';
import '../screens/quality_assurance/seed_labels/seed_label_list.dart';
import '../screens/quality_assurance/sr10planting_inspection/PlantingInspectionList.dart';
import '../screens/seed_stock/seed_stock/SeedStockList.dart';
import '../screens/seed_stock/seed_stock/StockExaminationRequestForm.dart';
import '../screens/seed_stock/seed_stock/StockExaminationRequestList.dart';
import '../screens/seed_stock/seed_stock/TransferStockForm.dart';
import '../screens/tasks/TasksCreateScreen.dart';
import '../theme/custom_theme.dart';
import '../widgets/DetailsScreen.dart';
import 'app_config.dart';

class Utils {
  static String get_file_url(String name) {
    String url = AppConfig.mainSiteUrl + "/storage/uploads";
    if (name == null || (name.length < 2)) {
      url += '/default.png';
    } else {
      url += '/${name}';
    }
    return url;
  }

  static Future<Position> get_device_location() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
    }

    Position p = await Geolocator.getCurrentPosition();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static void launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  static Future<void> boot_system() async {
    await SeedLabelModel.get_items();
    await CropsModel.get_items();
    await CropVarietyModel.get_items();
    await SeedLabelPackageModel.get_items();
  }

  static void init_theme() {
    AppTheme.resetFont();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: CustomTheme.primary,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: CustomTheme.primary,
      ),
    );
  }

  static void init_dark_theme() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: CustomTheme.primary,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: CustomTheme.primary,
      ),
    );
  }

  static void launchPhone(String phone_number) async {
    if (!await launch('tel:${phone_number}'))
      throw 'Could not launch $phone_number';
  }

  static void showSnackBar(
    String message,
    context, {
    color = Colors.white,
    background_color = Colors.green,
  }) {
    toast2(message, color: color);
    return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText(message, color: color),
        backgroundColor: background_color,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  static void toast2(
    String message, {
    color = Colors.white,
    bool is_long = false,
  }) {
    if (Colors.green == color) {
      color = CustomTheme.primary;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: is_long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: CustomTheme.primary,
      textColor: color,
      fontSize: 16.0,
    );
  }

  static String yes_no_parse(dynamic x) {
    if (x == null) {
      return 'No';
    }
    if (Utils.int_parse(x) == 1) {
      return 'Yes';
    } else {
      return 'No';
    }
  }

  static String get_form_field_value(dynamic _fKey, String field) {
    if (_fKey == null) {
      return "";
    }
    if (_fKey.currentState == null) {
      return "";
    }

    if (_fKey.currentState.fields == null) {
      return "";
    }
    if (_fKey.currentState?.fields[field] == null) {
      return "";
    }

    if (_fKey.currentState?.fields[field]?.value == null) {
      return "";
    }

    return Utils.string_parse(
      _fKey.currentState?.fields['seed_grower_in_past']?.value,
      '',
    );
  }

  static String string_parse(dynamic x, String y) {
    if (x == null) {
      return y;
    }
    if (x.toString().toString() == 'null') {
      return y;
    }
    return x.toString();
  }

  static int int_parse(dynamic x) {
    if (x == null) {
      return 0;
    }
    int temp = 0;
    try {
      temp = int.parse(x.toString());
    } catch (e) {
      temp = 0;
    }

    return temp;
  }

  static bool bool_parse(dynamic x) {
    int temp = 0;
    bool ans = false;
    try {
      temp = int.parse(x.toString());
    } catch (e) {
      temp = 0;
    }

    if (temp == 1) {
      ans = true;
    } else {
      ans = false;
    }
    return ans;
  }

  static double screen_width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screen_height(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Future<String> http_post(
    String path,
    Map<String, dynamic> body,
  ) async {
    bool is_online = await Utils.is_connected();
    if (!is_online) {
      return "";
    }

    // LoggedInUserModel u = await LoggedInUserModel.get_logged_in_user();

    Response response;

    final dio = Dio();

    // dio.httpClientAdapter = IOHttpClientAdapter()
    //   ..onHttpClientCreate = (client) {
    //     // Customize your HttpClient here
    //     client.badCertificateCallback = (cert, host, port) => true;
    //     return client;
    //   };

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

    /* var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    }; */
    var da = FormData.fromMap(body);

    try {
      String token = await LoggedInUserModel.get_token();

      response = await dio.post(
        AppConfig.apiBaseUrl + "/$path",
        data: da,
        options: Options(
          headers: <String, String>{
            "authorization": 'Bearer $token',
            //"user": "${u.id}",
            "Content-Type": "application/json",
            "accept": "application/json",
            'user_id': 'id.toString()',
          },
        ),
      );

      print(response.data);
      return jsonEncode(response.data);
    } on DioException catch (e) {
      print("error: ${e.response?.data}");
      return jsonEncode(e.response?.data);
    }
  }

  static Future<bool> is_logged_in() async {
    bool logged_in = false;
    LoggedInUserModel l = await LoggedInUserModel.get_logged_in_user();
    if (l.email.length < 4) {
      return false;
    }
    if (l.id == 1) {
      logged_in = false;
    } else {
      logged_in = true;
    }
    return logged_in;
  }

  static Future<bool> is_connected() async {
    bool is_connected = false;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      is_connected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      is_connected = true;
    }

    return is_connected;
  }

  static Future<String> http_get(String path, Map<String, dynamic> body) async {
    bool is_online = await Utils.is_connected();
    if (!is_online) {
      return "";
    }
    //LoggedInUserModel u = await LoggedInUserModel.get_logged_in_user();

    String token = await LoggedInUserModel.get_token();

    print(token);
    Response response;
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
    var da = FormData.fromMap(body);

    try {
      response = await dio.get(
        AppConfig.apiBaseUrl + "/${path}",
        queryParameters: body,
        options: Options(
          headers: <String, String>{
            //"user": "${u.id}",
            "Content-Type": "application/json",
            "accept": "application/json",
            "authorization": 'Bearer ${token}',
            //'user_id': u.id.toString(),
          },
        ),
      );

      return jsonEncode(response.data);
    } on DioError catch (e) {
      return jsonEncode(e.response?.data);
    }
  }

  // static Future<dynamic> init_databse() async {
  //   if (!Hive.isAdapterRegistered(60)) {
  //     Hive.registerAdapter(DynamicTableAdapter());
  //   }
  // }

  static navigate_to(String screen, context, {dynamic data = null}) {
    switch (screen) {
      case AppConfig.stockExaminationRequestList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                StockExaminationRequestList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.stockExaminationRequestForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                StockExaminationRequestForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.stockExaminationUpdateForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const StockExaminationUpdateForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.formSr4SList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => FormSr4SList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.formQDSList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => FormQDSList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.formSr6SList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => FormSr6SList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.plantingRetunList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PlantingRetunList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.detailsScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailsScreen(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.trackScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Scan(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.exportPermitList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ExportPermitList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.importPermitList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ImportPermitList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.detailsSr4Screen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailsSr4Screen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.onBoardingScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                OnBoardingScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.detailsFormQDSScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailsFormQDSScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.formSr4Screen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => FormSr4Screen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.seedLabForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SeedLabForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.seedLabelForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SeedLabelForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.importPermitForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ImportPermitForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.individualPlantingReturnForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const IndividualPlantingReturnForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.companyPlantingReturnForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                CompanyPlantingReturnForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.cropDeclarationForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                CropDeclarationForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.formSr6Screen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => FormSr6Screen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.seedLabelList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SeedLabelList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.myOrders:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                OrdersList(isMine: true),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.incomingOrders:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                OrdersList(isMine: false),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.seedStockList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SeedStockList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.transferStockForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                TransferStockForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.seedLabList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SeedLabList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.preOrderForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PreOrderForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.preOrdersList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PreOrdersList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.quotationList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => QuotationList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.plantingInspectionList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PlantingInspectionList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.cropDeclarationList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                CropDeclarationList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.cropInspectionList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                CropInspectionList(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.exportPermitForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const ExportPermitForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.formQDSScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => FormQDSScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.detailsSr6Screen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailsSr6Screen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.homeScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomeScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.tasksCreateScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                TasksCreateScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.registerScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => RegisterScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.loginScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => LoginScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.stockExamList:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => LoginScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }

  static Widget status_tell_widget(String status) {
    int val = Utils.int_parse(status);
    List<int> warning = [1, 2, 3, 4, 5, 6];
    Color bg_color = Colors.grey.shade200;
    Color color = Colors.grey.shade900;
    if (warning.contains(val)) {
      bg_color = Colors.yellow.shade600;
      color = Colors.black;
    }

    return FxContainer(
      padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: FxText(
        Utils.tell_status_new(status),
        fontWeight: 900,
        fontSize: 14,
        color: color,
      ),
      color: bg_color,
    );
  }

  static Widget tell_status_widget(String status) {
    int val = Utils.int_parse(status);
    List<int> danger = [4, 3, 6, 8, 12, 15];
    List<int> warning = [0, 2, 1,  9, 10, 13, 16, 17, 18];
    List<int> success = [5, 11, 14];
    List<int> blue = [7];
    Color bg_color = Colors.grey.shade200;
    Color color = Colors.grey.shade900;
    if (danger.contains(val)) {
      bg_color = Colors.red.shade500;
      color = Colors.black;
    } else if (warning.contains(val)) {
      bg_color = Colors.yellow.shade600;
      color = Colors.black;
    } else if (success.contains(val)) {
      bg_color = Colors.green.shade700;
      color = Colors.white;
    }else if (blue.contains(val)) {
      bg_color = const Color.fromARGB(255, 70, 136, 201);
      color = Colors.white;
    }

    return FxContainer(
      padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: FxText(
        Utils.tell_status(status),
        fontWeight: 900,
        fontSize: 14,
        color: color,
      ),
      color: bg_color,
    );
  }

  static bool is_deletable(String status) {
    int _status = 0;
    bool status_val = false;
    _status = Utils.int_parse(status);

    if (_status <= 1) {
      //status_val = "Pending";
      status_val = true;
    } else if (_status == 2) {
      //status_val = "Inspection assigned";
      status_val = false;
    } else if (_status == 3) {
      //status_val = "Halted";
      status_val = true;
    } else if (_status == 4) {
      //status_val = "Rejected";
      status_val = true;
    } else if (_status == 5) {
      //status_val = "Accepted";
      status_val = false;
    } else if (_status == 6) {
      //status_val = "Expired";
      status_val = true;
    } else if (_status == 7) {
      //status_val = "Provisional";
      status_val = false;
    } else if (_status == 8) {
      //status_val = "Used";
      status_val = true;
    } else if (_status == 9) {
      //status_val = "Lab inspection";
      status_val = false;
    } else if (_status == 10) {
      //status_val = "Lab test pending";
      status_val = false;
    } else if (_status == 11) {
      //status_val = "Marketable";
      status_val = false;
    } else if (_status == 12) {
      //status_val = "Not Marketable";
      status_val = true;
    } else if (_status == 13) {
      //status_val = "Pending for labeling";
      status_val = false;
    } else if (_status == 14) {
      //status_val = "Labels Printed";
      status_val = false;
    } else if (_status == 15) {
      //status_val = "Declined";
      status_val = true;
    } else if (_status == 16) {
      //status_val = "Initialized";
      status_val = false;
    } else if (_status == 17) {
      //status_val = "Skipped";
      status_val = false;
    } else if (_status == 18) {
      //status_val = "Skipped";
      status_val = false;
    }

    return status_val;
  }

  static String tell_status_new(status) {
    int _status = 0;
    String status_val = "-";
    _status = Utils.int_parse(status);

    if (_status <= 1) {
      status_val = "Pending";
    } else if (_status == 2) {
      status_val = "Shipping";
    } else if (_status == 3) {
      status_val = "Delivered";
    } else if (_status == 4) {
      status_val = "Cancelled";
    } else if (_status == 5) {
      status_val = "Processing";
    } else if (_status == 6) {
      status_val = "Received";
    } else {
      status_val = "Pending";
    }
    return status_val;
  }

  static String tell_status(String status) {
    int _status = 0;
    String status_val = "-";
    _status = Utils.int_parse(status);

    if (_status <= 1) {
      status_val = "Pending";
    } else if (_status == 2) {
      status_val = "Inspection assigned";
    } else if (_status == 3) {
      status_val = "Halted";
    } else if (_status == 4) {
      status_val = "Rejected";
    } else if (_status == 5) {
      status_val = "Accepted";
    } else if (_status == 6) {
      status_val = "Expired";
    } else if (_status == 7) {
      status_val = "Provisional";
    } else if (_status == 8) {
      status_val = "Used";
    } else if (_status == 9) {
      status_val = "Lab inspection";
    } else if (_status == 10) {
      status_val = "Lab test pending";
    } else if (_status == 11) {
      status_val = "Marketable";
    } else if (_status == 12) {
      status_val = "Not Marketable";
    } else if (_status == 13) {
      status_val = "Pending for labeling";
    } else if (_status == 14) {
      status_val = "Labels Printed";
    } else if (_status == 15) {
      status_val = "Declined";
    } else if (_status == 16) {
      status_val = "Initialized";
    } else if (_status == 17) {
      status_val = "Skipped";
    } else if (_status == 18) {
      status_val = "Under review";
    }

    return status_val;
  }

  static void go_to_home(context) {
    Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (r) => false);
  }

  /* static Future<void> logout() async {
    await LoggedInUserModel.delete_all_items();
    await SeedLabelModel.delete_all_items();
    await FormSr6Model.delete_all_items();
    await QDSModel.delete_all_items();
    return;
  } */

  static Future<void> logout() async {
    try {
      await LoggedInUserModel.delete_all_items();
      await SeedLabelModel.delete_all_items();
      await FormSr6Model.delete_all_items();
      await QDSModel.delete_all_items();

      // Optional: Clear any shared preferences or secure storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      /* // Optional: Reset in-memory flags or singleton states
    AppSt.isLoggedIn = false;
    AppState.currentUser = null; */

      print("Logout completed successfully");
    } catch (e) {
      print("Logout failed: $e");
    }
  }

  static Future<void> showConfirmDialog(
    BuildContext context,
    Function onPositiveClick,
    Function onNegativeClick, {
    String message = "Please confirm this action",
    String positive_text = "Confirm",
    String negative_text = "",
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: FxSpacing.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FxText("${message}\n", fontWeight: 500),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Column(
                        children: [
                          FxButton.block(
                            onPressed: () {
                              onPositiveClick();
                              Navigator.pop(context);
                            },
                            borderRadiusAll: 4,
                            elevation: 0,
                            child: FxText(
                              positive_text,
                              letterSpacing: 0.3,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          negative_text.isEmpty
                              ? SizedBox()
                              : FxButton.outlined(
                                  onPressed: () {
                                    onNegativeClick();
                                    Navigator.pop(context);
                                  },
                                  borderRadiusAll: 4,
                                  elevation: 0,
                                  child: FxText(
                                    negative_text,
                                    letterSpacing: 0.3,
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
