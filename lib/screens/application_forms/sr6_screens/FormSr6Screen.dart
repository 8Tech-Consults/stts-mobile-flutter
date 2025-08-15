import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';
import '../../../models/CropsModel.dart';
import '../../../models/FormSr6Model.dart';
import '../../../models/ProjectModel.dart';
import '../../../models/option_picker_model.dart';
import '../../../screens/option_pickers/single_option_picker.dart';

class FormSr6Screen extends StatefulWidget {
  const FormSr6Screen({super.key});

  @override
  State<FormSr6Screen> createState() => FormSr6ScreenState();
}

late CustomTheme customTheme;

class FormSr6ScreenState extends State<FormSr6Screen> {
  String nature_of_off = "";
  SrFormController srFormController = SrFormController();

  AddApplicationForm addSr6Form = AddApplicationForm();

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    srFormController.getCrops();
    super.initState();
  }

  @override
  void dipose() {}

  bool isDark = false;
  bool is_loading = false;
  bool main_loading = false;
  FormSr6Model item = new FormSr6Model();
  List<String> selected_crops_ids = [];
  String selected_crops_text = "";
  List<String> selectedCrops = [];

  List<FormSr6Model> sr6s = [];

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
              // remove back button in appbar.

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
                          'SR6 form',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: 700,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: Text("")),
                  (is_loading)
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {},
                          child: Container(
                            padding: FxSpacing.x(10),
                            child: const Icon(
                              CupertinoIcons.check_mark,
                              size: 25,
                              color: Colors.white,
                            ),
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
                                                labelText: "Category",
                                              ),
                                              name: "type",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              items: AppConfig.sr6FormCategories
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
                                            FormBuilderTextField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "company_initials",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Company initials'),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Company initials",
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
                                              name: "phone_number",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Phone number'),
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
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Years of experience as seed grower",
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              name: "years_of_expirience",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'This field '),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 15),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Select Crop",
                                              ),
                                              name: "crop",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Select Crop'),
                                              onChanged: (value) => {
                                                setState(() {
                                                  if (selectedCrops
                                                      .contains(value)) {
                                                  } else {
                                                    selectedCrops
                                                        .add(value.toString());
                                                  }
                                                })
                                              },
                                              items: model.crops
                                                  .map(
                                                    (options) =>
                                                        DropdownMenuItem(
                                                      value: options.name,
                                                      child: Text(
                                                        options.name.toString(),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 15),
                                            Column(
                                              children: List.generate(
                                                selectedCrops.length,
                                                (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                            ),
                                                            height: 30,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: MyColors
                                                                  .primary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Center(
                                                                  child: Text(
                                                                    "Crop: ${selectedCrops[index]} ",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        Positioned(
                                                            right: 0,
                                                            top: 0,
                                                            child: Center(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    selectedCrops
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    size: 8,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (selectedCrops.isNotEmpty)
                                              const SizedBox(
                                                height: 50,
                                              ),
                                            FxText(
                                              'I/We wish to apply for a license to produce seed as indicated below',
                                              textAlign: TextAlign.start,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Have you been a seed grower in the past?",
                                              ),
                                              name: "seed_grower_in_past",
                                              dropdownColor: Colors.white,
                                              onChanged: (dynamic value) {
                                                setState(() {});
                                              },
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
                                            (!isYes('seed_grower_in_past',
                                                    'Yes'))
                                                ? const SizedBox(height: 10)
                                                : FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter Previous grower number",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name:
                                                        "previous_grower_number",
                                                    textInputAction:
                                                        TextInputAction.next,
                                                  ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Enter field history",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "cropping_histroy",
                                              minLines: 4,
                                              maxLines: 5,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Address'),
                                              textInputAction:
                                                  TextInputAction.newline,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have adequate storage facilities to handle the resultant seed?",
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
                                                    "Do you have adequate isolation?",
                                              ),
                                              name: "have_adequate_isolation",
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
                                                        child: Text('$options'),
                                                      ))
                                                  .toList(),
                                            ),
                                            SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Do you have adequate labor to carry out all farm operations in a timely manner?",
                                              ),
                                              name: "have_adequate_labor",
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
                                                        child: Text('$options'),
                                                      ))
                                                  .toList(),
                                            ),
                                            SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Are you aware that only seed that meets the minimum standards shall be accepted as certified seed?",
                                              ),
                                              name:
                                                  "aware_of_minimum_standards",
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
                                                        child: Text('$options'),
                                                      ))
                                                  .toList(),
                                            ),
                                            SizedBox(height: 10),
                                            MyWidgets.image_picker(
                                                'Add payment receipt photo',
                                                local_image_path,
                                                () => {
                                                      _show_bottom_sheet_photo(
                                                          context)
                                                    }, () {
                                              setState(() {
                                                local_image_path = "";
                                              });
                                            }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyWidgets.image_picker(
                                                'Attach supportive document',
                                                local_image_path,
                                                () => {
                                                      _show_bottom_sheet_photo(
                                                          context)
                                                    }, () {
                                              setState(() {
                                                local_image_path = "";
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
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.red),
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
                                if (local_image_path.isEmpty) {
                                  Utils.showSnackBar(
                                      "Please pick a receipt photo.", context,
                                      background_color: Colors.red);
                                  return;
                                } else {
                                  addSr6Form.type =
                                      _fKey.currentState?.fields['type']?.value;
                                  addSr6Form.nameOfApplicant = _fKey
                                      .currentState
                                      ?.fields['name_of_applicant']
                                      ?.value;

                                  addSr6Form.address = _fKey
                                      .currentState?.fields['address']?.value;
                                  addSr6Form.premisesLocation = _fKey
                                      .currentState
                                      ?.fields['premises_location']
                                      ?.value;
                                  addSr6Form.yearsOfExpirience = int.parse(_fKey
                                      .currentState
                                      ?.fields['years_of_expirience']
                                      ?.value);
                                  addSr6Form.seedGrowerInPast = (_fKey
                                              .currentState
                                              ?.fields['seed_grower_in_past']
                                              ?.value ==
                                          "Yes")
                                      ? "1"
                                      : "0";

                                  addSr6Form.haveAdequateStorage = (_fKey
                                              .currentState
                                              ?.fields['have_adequate_storage']
                                              ?.value ==
                                          "Yes")
                                      ? "1"
                                      : "0";
                                  addSr6Form.haveAdequateLand = (_fKey
                                              .currentState
                                              ?.fields['have_adequate_labor']
                                              ?.value ==
                                          "Yes")
                                      ? "1"
                                      : " 0";

                                  addSr6Form.administratorId =
                                      locator<UserController>().user?.id;
                                  addSr6Form.companyInitials = _fKey
                                      .currentState
                                      ?.fields['company_initials']
                                      ?.value;
                                  addSr6Form.phoneNumber = "0776401993";
                                  addSr6Form.haveAdequateIsolation = "1";
                                  addSr6Form.croppingHistroy = "1";
                                  addSr6Form.haveAdequateLabor = "1";
                                  addSr6Form.awareOfMinimumStandards = "1";
                                  addSr6Form.signatureOfApplicant =
                                      "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD//+63ZhWjp95ukHmHK5GK8mth3Fn0uGxSqJM7C3mASPIIH1rSM5jjDIeG42g1h2kwkTB5x/";
                                  model.submitSr6Form(addSr6Form);
                                }
                              },
                              backgroundColor: CustomTheme.primary,
                              child: FxText(
                                "SUBMIT SR6 FORM",
                                fontSize: 18,
                                color: customTheme.cookifyOnPrimary,
                              )),
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

  void _show_bottom_sheet_photo(context) {
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
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        do_pick_image('camera');
                      },
                      dense: false,
                      leading:
                          const Icon(Icons.camera_alt, color: MyColors.primary),
                      title: FxText("Camera",
                          fontWeight: 600, color: MyColors.primary),
                    ),
                    ListTile(
                      dense: false,
                      onTap: () => {do_pick_image("gallery")},
                      leading: const Icon(Icons.photo_library_sharp,
                          color: MyColors.primary),
                      title: FxText("Gallery",
                          fontWeight: 600, color: MyColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String local_image_path = "";

  do_pick_image(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.camera);
      if (pic != null) {
        local_image_path = pic.path;
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        local_image_path = pic.path;
      }
    }

    setState(() {});
  }

  final _fKey = GlobalKey<FormBuilderState>();
  String error_message = "";

  String project_id = "";
  String assigned_to = "";
  String project_text = "";
  String location_sub_name = "";
  String location_id = "";
  bool is_uploading = false;

  pick_project() async {
    if (is_loading) {
      return;
    }

    setState(() {
      is_loading = true;
    });

    List<ProjectModel> items = await ProjectModel.get_items();
    List<OptionPickerModel> local_items = [];
    items.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = "1";
      item.id = element.id.toString();
      item.name = element.name.toString();
      local_items.add(item);
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleOptionPicker(
              "Select crops", local_items, ['1', '3', '6', '5', '4'], false)),
    );

    if (result != null) {
      if ((result['selected'] != null)) {
        setState(() {});
      }
    }
  }

  pick_crops() async {
    if (is_loading) {
      return;
    }
    setState(() {
      //is_loading = true;
    });

    List<CropsModel> items = await CropsModel.get_items();
    List<OptionPickerModel> local_items = [];
    items.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = "1";
      item.id = element.id.toString();
      item.name = element.name.toString();
      local_items.add(item);
    });

    setState(() {
      is_loading = false;
    });
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleOptionPicker(
              "Select a crops", local_items, selected_crops_ids, false)),
    );

    if (result != null) {
      if ((result['selected'] != null)) {
        selected_crops_text = "";

        List<String> selected_items = [];

        result['selected'].map((element) {
          selected_items.add(element.toString());
        }).toList();

        bool is_first = true;

        items.forEach((element) {
          if (selected_items.contains(element.id.toString())) {
            if (is_first) {
              is_first = false;
              selected_crops_text += element.name.toString();
            } else {
              selected_crops_text += ", " + element.name.toString();
            }
          }
        });
        _fKey.currentState?.patchValue({
          'selected_crops_text': selected_crops_text,
        });

        setState(() {});
      }
    }
  }

  showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _InternetCheckDialog();
        });
  }

  bool isYes(String field, String value) {
    if ((Utils.get_form_field_value(_fKey, field) == value)) {
      return true;
    } else {
      return false;
    }
  }
}

class _InternetCheckDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        decoration: new BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                size: 40,
                color: theme.colorScheme.onBackground.withAlpha(220),
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: FxText("No Internet!", fontWeight: 700)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: FxText("Please turn on internet", fontWeight: 500)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: FxButton(
                    elevation: 2,
                    borderRadiusAll: 4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: FxText("CREATE ANOTHER TASK",
                        fontWeight: 600,
                        letterSpacing: 0.3,
                        color: theme.colorScheme.onPrimary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
