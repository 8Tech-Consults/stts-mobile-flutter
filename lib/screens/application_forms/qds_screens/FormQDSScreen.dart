import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';
import '../../../models/CropsModel.dart';
import '../../../models/EmployeeModel.dart';
import '../../../models/ProjectModel.dart';
import '../../../models/QDSModel.dart';
import '../../../models/option_picker_model.dart';
import '../../../screens/option_pickers/single_option_picker.dart';

class FormQDSScreen extends StatefulWidget {
  const FormQDSScreen({super.key});

  @override
  State<FormQDSScreen> createState() => FormQDSScreenState();
}

late CustomTheme customTheme;

class FormQDSScreenState extends State<FormQDSScreen> {
  String nature_of_off = "";

  SrFormController srFormController = SrFormController();

  AddApplicationForm addQdsForm = AddApplicationForm();

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
    srFormController.getCrops();
  }

  @override
  void dipose() {}

  bool isDark = false;
  bool is_loading = false;
  bool main_loading = true;
  List<String> selected_crops_ids = [];
  String selected_crops_text = "";
  List<String> selectedCrops = [];

  QDSModel item = new QDSModel();

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
                        child: Icon(
                          CupertinoIcons.clear,
                          color: Colors.white,
                          size: 20,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Form QDS',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: 500,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: Text("")),
                  (is_loading)
                      ? const Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            //init_form();
                          },
                          child: Container(
                              padding: FxSpacing.x(10),
                              child: Icon(
                                CupertinoIcons.check_mark,
                                color: Colors.white,
                                size: 25,
                              )),
                        ),
                ],
              ),
            ),
            body: FormBuilder(
              key: _fKey,
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        top: 5,
                                        right: 15,
                                      ),
                                      child: Column(
                                        children: [
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
                                              )),
                                          SizedBox(height: 10),

                                          FormBuilderTextField(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText: "Address of applicant",
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
                                          SizedBox(height: 10),
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
                                          SizedBox(height: 10),
                                          FormBuilderTextField(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Years of experience as a QDS producer",
                                            ),
                                            keyboardType: TextInputType.number,
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
                                                  (options) => DropdownMenuItem(
                                                    value: options.name,
                                                    child: Text(
                                                      options.name.toString(),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                          Column(
                                            children: List.generate(
                                              selectedCrops.length,
                                              (index) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Container(
                                                  margin: const EdgeInsets.only(
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
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
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
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          if (selectedCrops.isNotEmpty)
                                            const SizedBox(
                                              height: 50,
                                            ),
                                          FxText(
                                            'I/We wish to apply for a license to produce quality declared seed (QDS) as indicated below:',
                                            textAlign: TextAlign.start,
                                            color: Colors.black,
                                          ),
                                          // SizedBox(height: 10),
                                          // FormBuilderTextField(
                                          //     textCapitalization:
                                          //         TextCapitalization.sentences,
                                          //     name: "selected_crops_text",
                                          //     readOnly: true,
                                          //     onTap: () {
                                          //       pick_crops();
                                          //     },
                                          //     validator: MyWidgets
                                          //         .my_validator_field_required(
                                          //             context, 'This field'),
                                          //     textInputAction:
                                          //         TextInputAction.next,
                                          //     decoration:
                                          //         customTheme.inputDecoration3(
                                          //       labelText: "Select crops",
                                          //     )),
                                          SizedBox(height: 10),
                                          FormBuilderDropdown(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Have you been a QDS producer in the past?",
                                            ),
                                            name: "have_been_qds",
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
                                          FormBuilderTextField(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "If yes, Enter previous QDS grower number",
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "previous_grower_number",
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(height: 10),
                                          FormBuilderDropdown(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Do you have adequate storage facilities to handle the resultant seed?",
                                            ),
                                            name:
                                                "have_adequate_storage_facility",
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
                                          const SizedBox(height: 10),
                                          FormBuilderTextField(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText: "Enter field history ",
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
                                                  "Do you have adequate labor to carry out all farm operations in a timely manner?",
                                            ),
                                            name: "have_adequate_labor",
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
                                          const SizedBox(height: 10),
                                          (_fKey
                                                      .currentState
                                                      ?.fields[
                                                          'have_adequate_labor']
                                                      ?.value !=
                                                  'Yes')
                                              ? const SizedBox(height: 10)
                                              : FormBuilderTextField(
                                                  decoration: customTheme
                                                      .inputDecoration3(
                                                    labelText:
                                                        "Specify number of laborers",
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  name: "number_of_labors",
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                          SizedBox(height: 10),
                                          FormBuilderDropdown(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Do you have adequate isolation?",
                                            ),
                                            name: "have_adequate_isolation",
                                            onChanged: (dynamic value) {
                                              setState(() {});
                                            },
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
                                          (_fKey
                                                      .currentState
                                                      ?.fields[
                                                          'have_adequate_isolation']
                                                      ?.value !=
                                                  'Yes')
                                              ? SizedBox(height: 10)
                                              : FormBuilderTextField(
                                                  decoration: customTheme
                                                      .inputDecoration3(
                                                    labelText:
                                                        "Specify isolation distance (in Meters)",
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  name: "isolation_distance",
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                          SizedBox(height: 10),
                                          FormBuilderDropdown(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Are you aware that only seed that meets the minimum standards shall be accepted as certified seed?",
                                            ),
                                            name: "aware_of_minimum_standards",
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
                                          const SizedBox(height: 10),
                                          MyWidgets.image_picker(
                                              'Upload recommendation letter from DAO',
                                              recommendationImagePath,
                                              () => {
                                                    showBottomSheetPhoto(
                                                        context, 1)
                                                  }, () {
                                            setState(() {
                                              recommendationImagePath = "";
                                            });
                                          }),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MyWidgets.image_picker(
                                              'Upload certificate of registration',
                                              certificateImagePath,
                                              () => {
                                                    showBottomSheetPhoto(
                                                        context, 2)
                                                  }, () {
                                            setState(() {
                                              certificateImagePath = "";
                                            });
                                          }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MyWidgets.image_picker(
                                              'Upload payment receipt',
                                              paymenrImagePath,
                                              () => {
                                                    showBottomSheetPhoto(
                                                        context, 3)
                                                  }, () {
                                            setState(() {
                                              paymenrImagePath = "";
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

                              if (paymenrImagePath.isEmpty) {
                                Utils.showSnackBar(
                                    "Please pick a receipt photo.", context,
                                    background_color: Colors.red);
                                return;
                              } else {
                                addQdsForm.nameOfApplicant = _fKey.currentState
                                    ?.fields['name_of_applicant']?.value;
                                addQdsForm.type =
                                    _fKey.currentState?.fields['type']?.value;
                                addQdsForm.haveAdequateStorageFacility = (_fKey
                                            .currentState
                                            ?.fields[
                                                'have_adequate_storage_facility']
                                            ?.value ==
                                        "Yes")
                                    ? "1"
                                    : "0";
                                addQdsForm.signatureOfApplicant =
                                    "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD//+63ZhWjp95ukHmHK5GK8mth3Fn0uGxSqJM7C3mASPIIH1rSM5jjDIeG42g1h2kwkTB5x/";
                                addQdsForm.address = _fKey
                                    .currentState?.fields['address']?.value;
                                addQdsForm.premisesLocation = _fKey.currentState
                                    ?.fields['premises_location']?.value;
                                addQdsForm.yearsOfExperience = int.parse(_fKey
                                    .currentState
                                    ?.fields['years_of_expirience']
                                    ?.value);
                                addQdsForm.previousGrowerNumber = _fKey
                                    .currentState
                                    ?.fields['previous_grower_number']
                                    ?.value;
                                addQdsForm.administratorId =
                                    locator<UserController>().user?.id;
                                addQdsForm.phoneNumber = _fKey.currentState
                                    ?.fields['phone_number']?.value;
                                addQdsForm.farmLocation = _fKey.currentState
                                    ?.fields['premises_location']?.value;
                                addQdsForm.croppingHistory = _fKey.currentState
                                    ?.fields['cropping_histroy']?.value;
                                addQdsForm.isolationDistance = (_fKey
                                    .currentState
                                    ?.fields['isolation_distance']
                                    ?.value);

                                addQdsForm.numberOfLabors = (_fKey.currentState
                                    ?.fields['number_of_labors']?.value);

                                addQdsForm.haveBeenQds = (_fKey.currentState
                                            ?.fields['have_been_qds']?.value ==
                                        "Yes")
                                    ? 1
                                    : 0;
                                addQdsForm.haveAdequateIsolation = (_fKey
                                            .currentState
                                            ?.fields['have_adequate_isolation']
                                            ?.value ==
                                        "Yes")
                                    ? "1"
                                    : "0";

                                addQdsForm.haveAdequateLabor = (_fKey
                                            .currentState
                                            ?.fields['have_adequate_labor']
                                            ?.value ==
                                        "Yes")
                                    ? "1"
                                    : "0";
                                addQdsForm.awareOfMinimumStandards = (_fKey
                                            .currentState
                                            ?.fields[
                                                'aware_of_minimum_standards']
                                            ?.value ==
                                        "Yes")
                                    ? "1"
                                    : "0";

                                model.submitQdsForm(addQdsForm);
                              }
                            },
                            backgroundColor: CustomTheme.primary,
                            child: FxText(
                              "SUBMIT QDS FORM",
                              fontSize: 18,
                              color: customTheme.cookifyOnPrimary,
                            ),
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool is_yes(String field, String value) {
    print("=====romina 22===");
    if ((Utils.get_form_field_value(_fKey, field) == value)) {
      return true;
    } else {
      return false;
    }
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
          builder: (context) =>
              SingleOptionPicker("Select project", local_items, [], false)),
    );
    setState(() {
      is_loading = false;
    });
    if (result != null) {
      if ((result['id'] != null) && (result['text'] != null)) {
        project_id = result['id'];
        _fKey.currentState!.patchValue({
          'project_text': result['text'],
        });
        setState(() {});
      }
    }
  }

  pick_employee() async {
    if (is_loading) {
      return;
    }
    setState(() {
      is_loading = true;
    });

    List<EmployeeModel> items = await EmployeeModel.get_items();
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
          builder: (context) =>
              SingleOptionPicker("Select a person", local_items, [], false)),
    );
    if (result != null) {
      if ((result['id'] != null) && (result['text'] != null)) {
        project_id = result['id'];
        assigned_to = result['id'];
        _fKey.currentState!.patchValue({
          'assigned_to_text': result['text'],
        });
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

  String recommendationImagePath = "";
  String certificateImagePath = "";
  String paymenrImagePath = "";

  void showBottomSheetPhoto(context, int path) {
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
                        if (path == 1) {
                          doPickRecImage('camera');
                        }
                        if (path == 2) {
                          doPickCertImage('camera');
                        }
                        if (path == 3) {
                          doPickPayImage('camera');
                        }
                      },
                      dense: false,
                      leading:
                          const Icon(Icons.camera_alt, color: MyColors.primary),
                      title: FxText(
                        "Camera",
                        fontWeight: 600,
                        color: MyColors.primary,
                      ),
                    ),
                    ListTile(
                        dense: false,
                        onTap: () => {
                              if (path == 1)
                                {
                                  doPickRecImage('camera'),
                                },
                              if (path == 2)
                                {
                                  doPickCertImage('camera'),
                                },
                              if (path == 3)
                                {
                                  doPickPayImage('camera'),
                                },
                            },
                        leading: const Icon(Icons.photo_library_sharp,
                            color: MyColors.primary),
                        title: FxText(
                          "Gallery",
                          fontWeight: 600,
                          color: MyColors.primary,
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  doPickRecImage(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.camera);
      if (pic != null) {
        recommendationImagePath = pic.path;
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        recommendationImagePath = pic.path;
      }
    }

    setState(() {});
  }

  doPickCertImage(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.camera);
      if (pic != null) {
        certificateImagePath = pic.path;
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        certificateImagePath = pic.path;
      }
    }

    setState(() {});
  }

  doPickPayImage(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.camera);
      if (pic != null) {
        paymenrImagePath = pic.path;
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        paymenrImagePath = pic.path;
      }
    }

    setState(() {});
  }

  showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _InternetCheckDialog();
        });
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
