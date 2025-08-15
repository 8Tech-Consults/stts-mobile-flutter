import '../../../Constants/stts_uganda_base_exports.dart';
import '../../../Constants/stts_uganda_exports.dart';

class LabTechnicianInspectionForm extends StatefulWidget {
  final int? seedLabId;
  const LabTechnicianInspectionForm({super.key, required this.seedLabId});

  @override
  State<LabTechnicianInspectionForm> createState() =>
      LabTechnicianInspectionFormState();
}

late CustomTheme customTheme;

class LabTechnicianInspectionFormState
    extends State<LabTechnicianInspectionForm> {
  SeedController seedController = SeedController();
  int? selectedOption;
  UpdateLabResults addSampleAnalysis = UpdateLabResults();
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
                                                          "Enter pure seed (in percentage)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "purity",
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
                                                      labelText: "Inert matter",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "inert_matter",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Inert matter'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Other crop seeds",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "other_crop_seeds",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText: "Weed seed",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "weed_seed",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter Germination capacity (in percentage)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name:
                                                        "germination_capacity",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Enter Germination capacity (in percentage)'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText: "1st count",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "first_count",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Enter first count'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText: "Final count",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "final_count",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText: "Hard",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "hard",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Fresh Ungerminated",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "fresh",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Rotten or Dead",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "dead",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter Abnormal sprouts (in percentage)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "abnormal_sprouts",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Enter Abnormal sprouts (in percentage)'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter Moisture content (in percentage)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "moisture",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Enter Moisture content (in percentage)'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter percentage of Broken germs",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "broken_germs",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Enter percentage of Broken germs'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                          'Report recommendation')),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: const Text(
                                                            'Marketable'),
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
                                                            'Not Marketable'),
                                                        leading: Radio(
                                                          value: 5,
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
                                                  const SizedBox(
                                                    height: 100,
                                                  )
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
                                        addSampleAnalysis.abnormalSprouts =
                                            int.parse(_fKey
                                                .currentState
                                                ?.fields['abnormal_sprouts']
                                                ?.value);

                                        addSampleAnalysis.brokenGerms =
                                            int.parse(_fKey
                                                .currentState
                                                ?.fields['broken_germs']
                                                ?.value);

                                        addSampleAnalysis.germinationCapacity =
                                            int.parse(_fKey
                                                .currentState
                                                ?.fields['germination_capacity']
                                                ?.value);

                                        addSampleAnalysis.purity = int.parse(
                                            _fKey.currentState?.fields['purity']
                                                ?.value);

                                        addSampleAnalysis.reportRecommendation =
                                            "11";
                                        addSampleAnalysis.receptionistIsDone =
                                            true;

                                        model.submitLabTest(addSampleAnalysis,
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
  File? image;
}
