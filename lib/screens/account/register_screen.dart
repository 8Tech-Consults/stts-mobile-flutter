import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/add_user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  UserController userController = UserController();
  AddUser addUser = AddUser();
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userController,
      child: Consumer<UserController>(
        builder: (_, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(color: Colors.white)),
            body: FormBuilder(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  FxContainer(
                      borderRadiusAll: 0,
                      marginAll: 0,
                      paddingAll: 0,
                      child: Stack(
                        children: [
                          const Image(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/seeds_bg_3.png"),
                          ),
                          FxContainer(
                            marginAll: 0,
                            padding: EdgeInsets.only(top: 23),
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            bordered: true,
                            border:
                                Border.all(color: Colors.transparent, width: 2),
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
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Creating account",
                            style: MyText.title(context)?.copyWith(
                                color: MyColors.primary,
                                fontWeight: FontWeight.bold)),
                        Container(height: 10),
                        Container(
                            height: 4, width: 40, color: MyColors.primary),
                        Container(height: 10),
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              color: CustomTheme.bg_primary_light,
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  FormBuilderTextField(
                                    name: 'first_name',
                                    autofocus: true,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        // context,
                                        errorText: "First name is required.",
                                      ),
                                      FormBuilderValidators.minLength(
                                        // context,
                                        3,
                                        errorText: "Name too short.",
                                      ),
                                      FormBuilderValidators.maxLength(
                                        // context,
                                        30,
                                        errorText: "Name too long.",
                                      ),
                                    ]),
                                    decoration: InputDecoration(
                                        labelText: "First name",
                                        labelStyle: MyText.caption(context)),
                                  ),
                                  Container(height: 5),
                                  FormBuilderTextField(
                                    name: 'last_name',
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autofocus: true,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        // context,
                                        errorText: "Last name is required.",
                                      ),
                                      FormBuilderValidators.minLength(
                                        // context,
                                        3,
                                        errorText: "Name too short.",
                                      ),
                                      FormBuilderValidators.maxLength(
                                        // context,
                                        30,
                                        errorText: "Name too long.",
                                      ),
                                    ]),
                                    decoration: InputDecoration(
                                        labelText: "Last name",
                                        labelStyle: MyText.caption(context)),
                                  ),
                                  FormBuilderTextField(
                                    name: 'email',
                                    autofocus: true,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        // context,
                                        errorText: "Email address is required.",
                                      ),
                                      FormBuilderValidators.email(
                                        // context,
                                        errorText: "Enter valid email address.",
                                      ),
                                      FormBuilderValidators.minLength(
                                        // context,
                                        3,
                                        errorText: "Email address too short.",
                                      ),
                                      FormBuilderValidators.maxLength(
                                        // context,
                                        30,
                                        errorText: "Email address too long.",
                                      ),
                                    ]),
                                    decoration: InputDecoration(
                                        labelText: "Email address",
                                        labelStyle: MyText.caption(context)),
                                  ),
                                  Container(height: 5),
                                  FormBuilderTextField(
                                    obscureText: obsecure,
                                    name: 'password',
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelText: "PASSWORD",
                                      labelStyle: MyText.caption(context),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obsecure = !obsecure;
                                          });
                                        },
                                        child: obsecure
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        // context,
                                        errorText: "Password is required.",
                                      ),
                                      FormBuilderValidators.minLength(
                                        // context,
                                        3,
                                        errorText: "Password too short.",
                                      ),
                                      FormBuilderValidators.maxLength(
                                        // context,
                                        40,
                                        errorText: "Password too long.",
                                      ),
                                    ]),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Already have account?",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: CustomTheme.primary,
                                              fontSize: 16),
                                        ),
                                        onPressed: () {
                                          Utils.navigate_to(
                                              AppConfig.loginScreen, context);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  model.loading
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
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 55,
                            child: FxButton.block(
                              borderRadiusAll: 0,
                              child: Text("CREATE ACCOUNT",
                                  style: MyText.headline(context)
                                      ?.copyWith(color: Colors.white)),
                              onPressed: () {
                                addUser.email = _formKey
                                    .currentState?.fields['email']?.value;
                                addUser.firstName = _formKey
                                    .currentState?.fields['first_name']?.value;
                                addUser.name = _formKey
                                    .currentState?.fields['first_name']?.value;
                                addUser.password = _formKey
                                    .currentState?.fields['password']?.value;
                                addUser.lastName = _formKey
                                    .currentState?.fields['last_name']?.value;
                                model.registerUser(addUser);
                                _formKey.currentState?.reset();
                              },
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
