import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../utils/app_config.dart';
import '../../../utils/Utils.dart';
import '../../../utils/my_colors.dart';
import '../../controllers/user_controller.dart';
import '../../models/LoggedInUserModel.dart';
import '../../models/RespondModel.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/my_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  UserController userController = UserController();
  bool obsecure = true;

  Future<void> submit_form() async {
    if (!_formKey.currentState!.validate()) {
      Utils.showSnackBar("Please fix errors in the form.", context,
          background_color: Colors.red, color: Colors.white);
      return;
    }

    Map<String, dynamic> form_data_map = {};
    form_data_map = {
      'username': _formKey.currentState?.fields['username']?.value,
      'password': _formKey.currentState?.fields['password']?.value,
    };

    is_loading = true;
    error_message = "";
    setState(() {});

    RespondModel resp =
        RespondModel(await Utils.http_post('login', form_data_map));

    if (resp.code != 1) {
      is_loading = false;
      setState(() {});
      error_message = resp.message;
      
      return;
    }
    // print("Dio error: $error_message");
    log('data: $error_message');
    await LoggedInUserModel.save_token(resp.data.toString());

    if (!await Utils.is_connected()) {
      Utils.showSnackBar(
          "You are offline. Check your connection and try again.", context,
          background_color: Colors.green, color: Colors.white);

      is_loading = false;
      error_message = 'You are offline. Check your connection and try again.';
      setState(() {});

      return;
    }
    RespondModel resp_1 = RespondModel(await Utils.http_get('me', {}));

    if (resp_1.code != 1) {
      is_loading = false;
      error_message = 'Failed to get profile, ${resp_1.message}';
      setState(() {});
      return;
    }

    is_loading = false;
    setState(() {});
    await LoggedInUserModel.login_user(resp_1.data);

/*
    Utils.showSnackBar("Logged in successfully.", context,
        background_color: Colors.green, color: Colors.white);
*/

    Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (r) => false);
  }

  String error_message = "";
  bool is_loading = false;

  @override
  void initState() {
    Utils.init_theme();
  }

  @override
  Widget build(BuildContext context) {
    
    log('data: $error_message');
    log("🚀 App started");
    return ChangeNotifierProvider.value(
      value: userController,
      child: Consumer<UserController>(
        builder: (_, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(color: Colors.white),
            ),
            body: Stack(
              children: [
                ListView(
                  children: [
                    FxContainer(
                        borderRadiusAll: 0,
                        marginAll: 0,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        color: Colors.white,
                        child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  color: Colors.white,
                                ),
                                const Image(
                                  width: double.infinity,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("assets/images/maaif_1.png"),
                                ),
                                Container(
                                  height: 20,
                                  color: Colors.white,
                                  
                                ),
                                FxContainer(
                                    borderRadiusAll: 0,
                                    marginAll: 0,
                                    paddingAll: 0,
                                    child: Stack(
                                      children: [
                                        const Image(
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/seeds_bg_3.png"),
                                        ),
                                        FxContainer(
                                          marginAll: 0,
                                          padding:
                                              const EdgeInsets.only(top: 23),
                                          alignment: Alignment.center,
                                          color: Colors.transparent,
                                          bordered: true,
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 2),
                                          child: FxText(
                                            AppConfig.appName,
                                            textAlign: TextAlign.center,
                                            color: Colors.grey.shade900,
                                            fontSize: 20,
                                            height: 1.01,
                                            fontWeight: 900,
                                          ),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),//log('data: $error_message');
                                FxText.bodySmall("Sign in",
                                    style: MyText.title(context)?.copyWith(
                                        color: MyColors.primary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 30,
                                ),
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                      color: CustomTheme.bg_primary_light,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        children: <Widget>[
                                          Container(height: 25),
                                          FormBuilderTextField(
                                            name: 'username',
                                            autofocus: true,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                errorText:
                                                    "Username is required.",
                                              ),
                                              FormBuilderValidators.minLength(
                                                  3, // Minimum allowed characters
                                                  errorText: "Username too short.",
                                                ),
                                              FormBuilderValidators.maxLength(
                                                /* max:  */30,
                                                errorText: "Username too long.",
                                              ),
                                            ]),
                                            decoration: InputDecoration(
                                                labelText: "Username/Email",
                                                labelStyle:
                                                    MyText.caption(context)),
                                          ),
                                          Container(height: 25),
                                          FormBuilderTextField(
                                            name: 'password',
                                            obscureText: obsecure,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                              labelText: "Password",
                                              labelStyle:
                                                  MyText.caption(context),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    obsecure = !obsecure;
                                                  });
                                                },
                                                child: obsecure
                                                    ? const Icon(
                                                        Icons.visibility_off)
                                                    : const Icon(
                                                        Icons.visibility),
                                              ),
                                            ),
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                // context,
                                                errorText:
                                                    "Password is required.",
                                              ),
                                              FormBuilderValidators.minLength(
                                                // context,
                                                 3,
                                                errorText:
                                                    "Password too short.",
                                              ),
                                              FormBuilderValidators.maxLength(
                                                // context,
                                                 40,
                                                errorText: "Password too long.",
                                              ),
                                            ]),
                                          ),
                                          Container(height: 10),
                                          Container(
                                            child: Text(error_message,
                                                style: MyText.body2(context)
                                                    ?.copyWith(
                                                        color:
                                                            Colors.red[600])),
                                          ),
                                          Container(height: 5),
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              Text(
                                                "Don't have account?",
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontSize: 14),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(),
                                                child: Text(
                                                  "Create account",
                                                  style: TextStyle(
                                                      color:
                                                          CustomTheme.primary,
                                                      fontSize: 14),
                                                ),
                                                onPressed: () {
                                                  Utils.navigate_to(
                                                      AppConfig.registerScreen,
                                                      context);
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ))),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: model.loading
                      ? Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(15),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: FxButton.block(
                            borderRadiusAll: 0,
                            child: Text("SIGN IN",
                                style: MyText.body2(context)
                                    ?.copyWith(color: Colors.white)),
                            onPressed: () {
                              model.login(
                                _formKey
                                    .currentState?.fields['username']?.value,
                                _formKey
                                    .currentState?.fields['password']?.value,
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
