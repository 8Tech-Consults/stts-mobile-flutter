import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/add_planting_return.dart';
import 'package:STTS/models/assigned_sub_grower.dart';
import 'package:STTS/models/update_planting_return.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import '../../../models/PlantingReturnModel.dart';

class InitializePlantingReturnForm extends StatefulWidget {
  final AssignedInpection assignedInpection;
  const InitializePlantingReturnForm({
    super.key,
    required this.assignedInpection,
  });

  @override
  State<InitializePlantingReturnForm> createState() =>
      InitializePlantingReturnFormState();
}

late CustomTheme customTheme;

class InitializePlantingReturnFormState
    extends State<InitializePlantingReturnForm> {
  PlantingController plantingController = PlantingController();
  String nature_of_off = "";
  UpdatePlantingReturn updatePlantingReturn = UpdatePlantingReturn();

  int selectedOption = 0;
  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
    plantingController.init();
  }

  bool isDark = false;

  List<PlantingReturnModel> subgrower = [];

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
                          'Planting Return',
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
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Grower Name",
                                              ),
                                          initialValue: widget
                                              .assignedInpection
                                              .assignedSubGrower
                                              ?.name,
                                          name: "",
                                          readOnly: true,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Grower Name',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Planting date",
                                              ),
                                          initialValue:
                                              "${widget.assignedInpection.assignedSubGrower?.plantingdate}",
                                          name: "plantingdate",
                                          readOnly: true,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Planting date',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),

                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          // keyboardType: TextInputType.text,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Crop",
                                              ),
                                          initialValue: widget
                                              .assignedInpection
                                              .assignedSubGrower?.crop?.name,
                                          name: "crop",
                                          readOnly: true,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Crop',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Variety",
                                              ),

                                          // initialValue:
                                          //     "${model.getVarietyName(widget.assignedInpection.assignedSubGrower?.variety)}",
                                          initialValue:
                                              "${widget.assignedInpection.assignedSubGrower?.variety}",
                                          name: "variety1",
                                          readOnly: true,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Variety',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderDropdown(
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
                                                    'Certificate seed',
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
                                        FormBuilderDropdown(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText:
                                                    "Select Crop variety",
                                              ),
                                          name: "variety",
                                          dropdownColor: Colors.white,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Select Crop variety',
                                              ),
                                          items: model.cropVarieties
                                              .map(
                                                (options) => DropdownMenuItem(
                                                  value: options.id.toString() ?? "N/A",
                                                  child: Text(
                                                    options.name.toString(),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        const SizedBox(height: 20),
                                        if (widget
                                                .assignedInpection
                                                .assignedSubGrower
                                                ?.status ==
                                            '2')
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: const Text(
                                                  'Initialize form',
                                                ),
                                                leading: Radio(
                                                  value: 1,
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
                                // updatePlantingReturn.crop =
                                //     _fKey.currentState?.fields['crop']?.value;
                                updatePlantingReturn.variety = _fKey
                                    .currentState?.fields['variety']?.value
                                    .toString();
                                // updatePlantingReturn.seedClass = _fKey
                                //     .currentState?.fields['seed_class']?.value;
                                updatePlantingReturn.status = "16";

                                // print(
                                //    "ajajahahhaha:${jsonEncode(addPlantingReturn)}");
                                model.updatePlantingReturn(
                                  updatePlantingReturn,
                                  widget
                                      .assignedInpection
                                      .assignedSubGrower
                                      ?.id,
                                );
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
