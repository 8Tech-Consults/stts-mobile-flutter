import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';

class SeedLabInspectionForm extends StatefulWidget {
  final int? seedLabId;
  const SeedLabInspectionForm({super.key, required this.seedLabId});

  @override
  State<SeedLabInspectionForm> createState() => SeedLabInspectionFormState();
}

late CustomTheme customTheme;

class SeedLabInspectionFormState extends State<SeedLabInspectionForm> {
  SeedController seedController = SeedController();
  int? selectedOption;
  AddSampleAnalysis addSampleAnalysis = AddSampleAnalysis();
  List<dynamic> selectedTestsRequired = [];
  List<Map<String, dynamic>> testsRequired = [
    {
      "name": "Moisture content",
    },
    {
      "name": "Purity",
    },
    {
      "name": "Germination",
    },
    {
      "name": "Seed health",
    }
  ];

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
  }

  bool isDark = false;

  Future<bool> init_form() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();

    return ChangeNotifierProvider.value(
      value: seedController,
      child: Consumer<SeedController>(
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
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Seed sample analysis',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: 700,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Text(""),
                  ),
                ],
              ),
            ),
            body: FutureBuilder(
                future: init_form(),
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
                                        padding: EdgeInsets.all(0),
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
                                                  FormBuilderTextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter weight of Sample (Kgs)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "sample_weight",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'sample weight'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter packaging",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "packaging",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'packaging'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter Mother lot",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "mother_lot",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'mother lot'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderDropdown(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Sample condition",
                                                    ),
                                                    name: "sample_condition",
                                                    dropdownColor: Colors.white,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'This field '),
                                                    items: [
                                                      'Processed seed',
                                                      'Unprocessed seed',
                                                      'Treated seed',
                                                    ]
                                                        .map((options) =>
                                                            DropdownMenuItem(
                                                              value: options,
                                                              child:
                                                                  Text(options),
                                                            ))
                                                        .toList(),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  FormBuilderDropdown(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter tests required",
                                                    ),
                                                    name: "tests_required",
                                                    dropdownColor: Colors.white,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'This field is required '),
                                                    items: testsRequired
                                                        .map(
                                                          (options) =>
                                                              DropdownMenuItem(
                                                            value:
                                                                options['name'],
                                                            child: Text(
                                                                " ${options['name']}"),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) => {
                                                      setState(() {
                                                        selectedTestsRequired
                                                            .add(value);
                                                      })
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    children: List.generate(
                                                      selectedTestsRequired
                                                          .length,
                                                      (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 5),
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  height: 30,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: MyColors
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                              5),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "${selectedTestsRequired[index]} ",
                                                                          style:
                                                                              const TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                    ],
                                                                  )),
                                                              Positioned(
                                                                  right: 0,
                                                                  top: 0,
                                                                  child: Center(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          selectedTestsRequired
                                                                              .removeAt(index);
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4),
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            shape: BoxShape.circle),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              8,
                                                                          color:
                                                                              Colors.red,
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
                                                    height: 10,
                                                  ),
                                                  const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text('Decision')),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: const Text(
                                                            'Reject'),
                                                        leading: Radio(
                                                          value: 4,
                                                          groupValue:
                                                              selectedOption,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedOption =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: const Text(
                                                            'Accept'),
                                                        leading: Radio(
                                                          value: 9,
                                                          groupValue:
                                                              selectedOption,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedOption =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.red),
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
                                      } else {
                                        addSampleAnalysis.motherLot = (_fKey
                                            .currentState
                                            ?.fields['mother_lot']
                                            ?.value);

                                        addSampleAnalysis.packaging = _fKey
                                            .currentState
                                            ?.fields['packaging']
                                            ?.value;

                                        addSampleAnalysis.sampleCondition =
                                            (_fKey
                                                .currentState
                                                ?.fields['sample_condition']
                                                ?.value);

                                        addSampleAnalysis.testsRequired =
                                            selectedTestsRequired.toString();
                                        addSampleAnalysis.sampleWeight =
                                            int.parse(_fKey
                                                .currentState
                                                ?.fields['sample_weight']
                                                ?.value);
                                        addSampleAnalysis.status =
                                            selectedOption;
                                        model.submitSeedSampleAnalysis(
                                            addSampleAnalysis,
                                            widget.seedLabId);
                                        _fKey.currentState!.reset();
                                      }
                                    },
                                    backgroundColor: CustomTheme.primary,
                                    child: FxText(
                                      "SUBMIT",
                                      fontSize: 18,
                                      color: customTheme.cookifyOnPrimary,
                                    )),
                          )
                        ],
                      ),
                    )),
          );
        },
      ),
    );
  }

  final _fKey = GlobalKey<FormBuilderState>();
  String error_message = "";

  String project_id = "";
  String assigned_to = "";
  String project_text = "";
  String location_sub_name = "";
  String location_id = "";
  bool is_uploading = false;

  String local_image_path = "";
  File? image;
}
