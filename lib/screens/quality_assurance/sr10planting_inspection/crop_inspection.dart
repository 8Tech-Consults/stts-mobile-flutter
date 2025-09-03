import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/add_inspection.dart';
import 'package:STTS/models/add_planting_return.dart';
import 'package:STTS/models/assigned_sub_grower.dart';
import 'package:STTS/models/inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CropInspection extends StatefulWidget {
  final Inspection inspection;
  final bool isCrop;
  const CropInspection({
    super.key,
    required this.inspection,
    required this.isCrop,
  });
  

  @override
  State<CropInspection> createState() => CropInspectionState();
}

late CustomTheme customTheme;

class CropInspectionState extends State<CropInspection> {
  PlantingController plantingController = PlantingController();
  int? selectedOption;
  AddInspection addInspection = AddInspection();

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
    plantingController.init();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();
    return ChangeNotifierProvider.value(
      value: plantingController,
      child: Consumer<PlantingController>(
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
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Crop Inspection',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: 700,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: Text("")),
                  (model.isLoading)
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red,
                              ),
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
                                          initialValue: widget.inspection.form?.seedClass,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Seed class",
                                              ),
                                          name: "seed_class",
                                          dropdownColor: Colors.white,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'This field ',
                                              ),
                                          items:
                                              [
                                                    'Pre-Basic',
                                                    'Certified seed',
                                                    'Basic seed',
                                                    'Quality declared seed',
                                                  ]
                                                  .map(
                                                    (options) =>
                                                        DropdownMenuItem(
                                                          value: options,
                                                          child: Text(options),
                                                        ),
                                                  )
                                                  .toList(),
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          initialValue: widget.inspection.form?.sizeOfField,
                                          decoration: customTheme.inputDecoration3(
                                            labelText:
                                                "Enter size of field (in Acres)",
                                          ),
                                          name: "size_of_field",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.text,
                                          initialValue: widget.inspection.form?.offTypes,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Off types",
                                              ),
                                          name: "off_types",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.text,
                                          initialValue: widget.inspection.form?.diseases,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Diseases",
                                              ),
                                          name: "diseases",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.text,
                                          initialValue: widget.inspection.form?.noxiousWeeds,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Noxious weeds",
                                              ),
                                          name: "noxious_weeds",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.text,
                                          initialValue: widget.inspection.form?.otherFeatures,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Other features",
                                              ),
                                          name: "other_features",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.text,
                                          initialValue: widget.inspection.form?.otherWeeds,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Other weeds",
                                              ),
                                          name: "other_weeds",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          initialValue: widget.inspection.form?.isolationDistance,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Enter isolation distance(in meters)",
                                              ),
                                          name: "isolation_distance",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Crop variety",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          initialValue: widget
                                              .inspection
                                              .form
                                              ?.cropVariety
                                              ?.name,
                                          name: "variety",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderDropdown(
                                          initialValue: widget.inspection.form?.proposedDistance,
                                          decoration: customTheme.inputDecoration3(
                                            labelText:
                                                "Status of proposed isolation",
                                          ),
                                          name: "status_isolation",
                                          dropdownColor: Colors.white,
                                          items: ['Adequate', 'Inadequate']
                                              .map(
                                                (options) => DropdownMenuItem(
                                                  value: options,
                                                  child: Text(options),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          initialValue: widget.inspection.form?.plantCount,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Plant count",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "plant_count",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          initialValue: widget.inspection.form?.generalConditionsOfCrop,
                                          keyboardType: TextInputType.multiline,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText:
                                                    "General conditions of crop",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "general_conditions_of_crop",
                                          minLines: 3,
                                          maxLines: 6,
                                          textInputAction:
                                              TextInputAction.newline,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          initialValue: widget.inspection.form?.estimatedYield,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText:
                                                    "Enter estimated yield (kgs)",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "estimated_yield",
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          initialValue: widget.inspection.form?.furtherRemaks,
                                          keyboardType: TextInputType.multiline,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText:
                                                    "Enter any futher remarks",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "further_remaks",
                                          minLines: 3,
                                          maxLines: 6,
                                          textInputAction:
                                              TextInputAction.newline,
                                        ),
                                        const SizedBox(height: 10),
                                        if(widget.inspection.form?.isActive == '1' && (widget.inspection.form?.status == '1' || widget.inspection.form?.status == '2' ))
                                          Column(
                                            mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    const Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        " * Inspection decision",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        ListTile(
                                                          title: const Text('Rejected'),
                                                          leading: Radio(
                                                            value: 4,
                                                            groupValue: selectedOption,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedOption = value!;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        if (widget
                                                                .inspection
                                                                .inspectionType ==
                                                            "Pre-harvest inspection")
                                                          ListTile(
                                                            title: const Text('Accepted'),
                                                            leading: Radio(
                                                              value: 5,
                                                              groupValue: selectedOption,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedOption = value!;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        if (widget
                                                                .inspection
                                                                .inspectionType !=
                                                            "Pre-harvest inspection")
                                                          ListTile(
                                                            title: const Text('Skip'),
                                                            leading: Radio(
                                                              value: 17,
                                                              groupValue: selectedOption,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedOption = value!;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        if (widget
                                                                .inspection
                                                                .inspectionType !=
                                                            "Pre-harvest inspection")
                                                          ListTile(
                                                            title: const Text(
                                                              'Provisional',
                                                            ),
                                                            leading: Radio(
                                                              value: 7,
                                                              groupValue: selectedOption,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedOption = value!;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    if (selectedOption != 4)
                                                      FormBuilderTextField(
                                                        keyboardType:
                                                            TextInputType.multiline,
                                                        decoration: customTheme
                                                            .inputDecoration3(
                                                              labelText:
                                                                  "Enter status comment (Remarks)",
                                                            ),
                                                        textCapitalization:
                                                            TextCapitalization.sentences,
                                                        name: "status_comment",
                                                        minLines: 3,
                                                        maxLines: 6,
                                                        textInputAction:
                                                            TextInputAction.newline,
                                                      ),
                                                  ],
                                          ),
                                            
                                        
                                        const SizedBox(height: 50),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: 1, // 1000 list items
                        ),
                      ),
                    ],
                  ),
                  if(widget.inspection.form?.isActive == '1' && (widget.inspection.form?.status == '1' || widget.inspection.form?.status == '2'))
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red,
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
                                    background_color: Colors.red,
                                  );
                                  return;
                                } else {
                                  addInspection.diseases = _fKey
                                      .currentState
                                      ?.fields['diseases']
                                      ?.value;
                                  addInspection.variety = _fKey
                                      .currentState
                                      ?.fields['variety']
                                      ?.value
                                      .toString();
                                  addInspection.seedClass = _fKey
                                      .currentState
                                      ?.fields['seed_class']
                                      ?.value;
                                  addInspection.furtherRemaks = _fKey
                                      .currentState
                                      ?.fields['further_remaks']
                                      ?.value;
                                  addInspection.estimatedYield = _fKey
                                      .currentState
                                      ?.fields['estimated_yield']
                                      ?.value;
                                  //addInspection.isDone = '1';
                                  addInspection.isolationDistance = _fKey
                                      .currentState
                                      ?.fields['isolation_distance']
                                      ?.value;
                                  addInspection.offTypes = _fKey
                                      .currentState
                                      ?.fields['off_types']
                                      ?.value;
                                  addInspection.femaleReceptive = true;
                                  addInspection.status = selectedOption;
                                  addInspection.stage = int.parse(
                                    widget.inspection.form!.stage.toString(),
                                  );
                                  model.submitCropInspection(
                                    context,
                                    addInspection,
                                    widget.inspection.form?.id,
                                    widget.isCrop,
                                  );
                                  _fKey.currentState?.reset();
                                }
                              },
                              backgroundColor: CustomTheme.primary,
                              child: FxText(
                                "SUBMIT",
                                fontSize: 18,
                                color: customTheme.cookifyOnPrimary,
                              ),
                            ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final _fKey = GlobalKey<FormBuilderState>();

  //end pick varieties

  Future<void> pick_gps() async {
    Position p = await Utils.get_device_location();
    if (p != null) {
      _fKey.currentState?.patchValue({
        'gps_latitude': p.latitude.toString(),
        'gps_longitude': p.longitude.toString(),
      });

      setState(() {});
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
        decoration: BoxDecoration(
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
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: FxText("No Internet!", fontWeight: 700)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: FxText("Please turn on internet", fontWeight: 500),
              ),
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
                  child: FxText(
                    "CREATE ANOTHER TASK",
                    fontWeight: 600,
                    letterSpacing: 0.3,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
