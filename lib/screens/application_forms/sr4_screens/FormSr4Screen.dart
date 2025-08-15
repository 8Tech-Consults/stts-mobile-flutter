import 'package:STTS/stts_printer.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';

class FormSr4Screen extends StatefulWidget {
  const FormSr4Screen({super.key});

  @override
  State<FormSr4Screen> createState() => FormSr4ScreenState();
}

late CustomTheme customTheme;

class FormSr4ScreenState extends State<FormSr4Screen> {
  SrFormController srFormController = SrFormController();
  File? image;
  AddApplicationForm addSr4Form = AddApplicationForm();
  User? user;
  List<Map<String, dynamic>> categories = [
    {"id": 1, "name": "Seed merchant/Company"},
    {"id": 2, "name": "Seed Dealer/importer/exporter"},
  ];

  void getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user = User.fromJson(
        jsonDecode(sharedPreferences.getString('user') ?? ''),
      );
    });
  }

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    Utils.init_theme();
    super.initState();
    getPref();
  }

  bool isDark = false;
  List<FormSr4Model> sr4s = [];

  String localImagePath = "";
  late Map<String, dynamic> f = {};

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();
    return ChangeNotifierProvider.value(
      value: srFormController,
      child: Consumer<SrFormController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: CustomTheme.primary,
              elevation: 1,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: FxSpacing.x(0),
                        child: const Icon(
                          CupertinoIcons.clear,
                          color: Colors.white,
                          size: 20,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'SR4 form',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: 700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: FutureBuilder(
              builder: (context, snapshot) => FormBuilder(
                key: _fKey,
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 5,
                                          right: 15,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Application category?",
                                              ),
                                              name: "type",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Seed merchant/Company',
                                                'Seed Dealer/importer/exporter'
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "name_of_applicant",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Name of applicant'),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Name of applicant",
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Address of applicant",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "address",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Address'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Phone number",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "phone",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Phone'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Company initials",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "company_initials",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Address'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Premises location",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "premises_location",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Address'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Experienced in?",
                                              ),
                                              name: "expirience_in",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: AppConfig.sr4FormCategories
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Years of experience",
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              name: "years_of_expirience",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Address'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 15),
                                            FxText(
                                              'I/We wish to apply for a certificate as a seed stockist.',
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Applicant is applying for production of?",
                                              ),
                                              name: "dealers_in",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: AppConfig
                                                  .sr4MarketingOfOptions
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Applicant is applying for marketing of?",
                                              ),
                                              name: "marketing_of",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: AppConfig
                                                  .sr4MarketingOfOptions
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Size of land to handle basic seed",
                                                hintText:
                                                    'Specify Land size. (in Acres)',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              name: "land_size",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Land size'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do have adequate storage facilities to handle the resultant seed?",
                                              ),
                                              name: "have_adequate_storage",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Yes',
                                                'No',
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have adequate equipment to handle basic seed?",
                                              ),
                                              name: "have_adequate_equipment",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Yes',
                                                'No',
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "If yes, specify the equipment",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "eqipment",
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have contractual agreement with the growers you have recruited?",
                                              ),
                                              name:
                                                  "have_contractual_agreement",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Yes',
                                                'No',
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have adequate field officers to supervise and advise growers on all operation of seed production?",
                                              ),
                                              name:
                                                  "have_adequate_field_officers",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Yes',
                                                'No',
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "What is your source of seed?",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "souce_of_seed",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Source of seed '),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have adequate land for production of basic seed?",
                                              ),
                                              name:
                                                  "have_adequate_land_for_production",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Yes',
                                                'No',
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have an internal quality program?",
                                              ),
                                              name:
                                                  "have_internal_quality_program",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: [
                                                'Yes',
                                                'No',
                                              ]
                                                  .map((options) =>
                                                      DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            MyWidgets.image_picker(
                                                'Add payment receipt photo',
                                                localImagePath,
                                                () => {
                                                      showBottomSheetPhoto(
                                                          context)
                                                    }, () {
                                              setState(() {
                                                localImagePath = "";
                                              });
                                            }),
                                            const SizedBox(height: 65),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                            childCount: 1, // 1000 list items
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: (model.isLoading)
                          ? Container(
                              color: Colors.white,
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red),
                                  ),
                                ),
                              ),
                            )
                          : FxButton.block(
                              borderRadiusAll: 0,
                              onPressed: () {
                                if (!_fKey.currentState!.validate()) {
                                  Utils.showSnackBar(
                                      "Please Check errors in the form and fix them first.",
                                      context,
                                      background_color: Colors.red);
                                  return;
                                }

                                if (localImagePath.isEmpty) {
                                  Utils.showSnackBar(
                                      "Please pick a receipt photo.", context,
                                      background_color: Colors.red);
                                  return;
                                } else {
                                  addSr4Form.administratorId =
                                      locator<UserController>().user?.id;
                                  addSr4Form.yearsOfExpirience = 2;
                                  addSr4Form.nameOfApplicant = _fKey
                                      .currentState
                                      ?.fields['name_of_applicant']
                                      ?.value;
                                  addSr4Form.address = _fKey
                                      .currentState?.fields['address']?.value;
                                  addSr4Form.companyInitials = _fKey
                                      .currentState
                                      ?.fields['company_initials']
                                      ?.value;
                                  addSr4Form.premisesLocation = _fKey
                                      .currentState
                                      ?.fields['premises_location']
                                      ?.value;
                                  addSr4Form.souceOfSeed = _fKey.currentState
                                      ?.fields['souce_of_seed']?.value;
                                  f["land_size"] = _fKey
                                      .currentState?.fields['land_size']?.value;
                                  f["eqipment"] = _fKey
                                      .currentState?.fields['eqipment']?.value;
                                  addSr4Form.type =
                                      _fKey.currentState?.fields['type']?.value;
                                  addSr4Form.expirienceIn = _fKey.currentState
                                      ?.fields['expirience_in']?.value;
                                  addSr4Form.marketingOf = _fKey.currentState
                                      ?.fields['marketing_of']?.value;
                                  addSr4Form.dealersIn = _fKey.currentState
                                      ?.fields['dealers_in']?.value;

                                  addSr4Form.haveAdequateStorage = _fKey
                                              .currentState
                                              ?.fields['have_adequate_storage']
                                              ?.value ==
                                          "yes"
                                      ? "1"
                                      : "0";
                                  addSr4Form.haveAdequateEquipment = _fKey
                                              .currentState
                                              ?.fields[
                                                  'have_adequate_equipment']
                                              ?.value ==
                                          "yes"
                                      ? "1"
                                      : "0";
                                  addSr4Form.haveContractualAgreement = _fKey
                                              .currentState
                                              ?.fields[
                                                  'have_contractual_agreement']
                                              ?.value ==
                                          "yes"
                                      ? "1"
                                      : "0";
                                  addSr4Form
                                      .haveAdequateLandForProduction = _fKey
                                              .currentState
                                              ?.fields[
                                                  'have_adequate_land_for_production']
                                              ?.value ==
                                          "yes"
                                      ? "1"
                                      : "0";
                                  addSr4Form.haveAdequateFieldOfficers = _fKey
                                              .currentState
                                              ?.fields[
                                                  'have_adequate_field_officers']
                                              ?.value ==
                                          "yes"
                                      ? "1"
                                      : "0";

                                  addSr4Form.haveInternalQualityProgram = _fKey
                                              .currentState
                                              ?.fields[
                                                  'have_internal_quality_program']
                                              ?.value ==
                                          "yes"
                                      ? "1"
                                      : "0";
                                  addSr4Form.haveAdequateFieldOfficers = '1';
                                  addSr4Form.phoneNumber = _fKey
                                      .currentState?.fields['phone']?.value;
                                  addSr4Form.haveAdequateLand = "1";
                                  model.submitSr4Form(addSr4Form);
                                  _fKey.currentState!.reset();
                                }
                              },
                              backgroundColor: CustomTheme.primary,
                              child: FxText(
                                "SUBMIT SR4 FORM",
                                fontSize: 18,
                                color: customTheme.cookifyOnPrimary,
                              ),
                            ),
                    )
                  ],
                ),
              ),
              future: null,
            ),
          );
        },
      ),
    );
  }

  void showBottomSheetPhoto(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        doPickImage('camera');
                      },
                      dense: false,
                      leading:
                          const Icon(Icons.camera_alt, color: MyColors.primary),
                      title: FxText("Camera", fontWeight: 600),
                    ),
                    ListTile(
                      dense: false,
                      onTap: () => {doPickImage("gallery")},
                      leading: const Icon(Icons.photo_library_sharp,
                          color: MyColors.primary),
                      title: FxText("Gallery", fontWeight: 600),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  doPickImage(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.camera);
      if (pic != null) {
        localImagePath = pic.path;
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        localImagePath = pic.path;
      }
    }

    setState(() {});
  }

  final _fKey = GlobalKey<FormBuilderState>();
  String errorMessage = "";

  String projectId = "";
  String assignedTo = "";
  String projectText = "";
  String locationSubName = "";
  String locationId = "";
  bool isUploading = false;
}
