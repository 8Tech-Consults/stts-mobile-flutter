import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/CropVarietyModel.dart';
import 'package:STTS/models/add_planting_return.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../models/LoggedInUserModel.dart';
import '../../../models/PlantingReturnModel.dart';
import '../../../models/RespondModel.dart';
import '../../../models/option_picker_model.dart';
import '../../../screens/option_pickers/single_option_picker.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/Utils.dart';
import '../../../widgets/my_widgets.dart';

class IndividualPlantingReturnForm extends StatefulWidget {
  const IndividualPlantingReturnForm({super.key});

  @override
  State<IndividualPlantingReturnForm> createState() =>
      IndividualPlantingReturnFormState();
}

late CustomTheme customTheme;

class IndividualPlantingReturnFormState
    extends State<IndividualPlantingReturnForm> {
  PlantingController plantingController = PlantingController();
  String nature_of_off = "";
  AddPlantingReturn addPlantingReturn = AddPlantingReturn();

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
                          'Grower Planting Return',
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
                                                labelText:
                                                    "Garden Size (in Accre)",
                                              ),
                                          name: "size",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Garden Size (in Acre)',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderDropdown(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Select Crop",
                                              ),
                                          name: "crop",
                                          dropdownColor: Colors.white,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Select Crop',
                                              ),
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
                                                  value: options.name ?? "N/A",
                                                  child: Text(
                                                    options.name.toString(),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Field name",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "field_name",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Filed name',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.text,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText:
                                                    "Person responsible ",
                                              ),
                                          name: "name",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Person responsible',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "District",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "district",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'District',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Sub-County",
                                              ),
                                          keyboardType: TextInputType.text,
                                          name: "subcounty",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Sub County ',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 15),
                                        FormBuilderTextField(
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Village",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "village",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Village',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderDateTimePicker(
                                          name: 'planting_date',
                                          // onChanged: _onChanged,
                                          inputType: InputType.date,
                                          decoration: const InputDecoration(
                                            labelText: 'Planting date',
                                          ),
                                          initialTime: const TimeOfDay(
                                            hour: 8,
                                            minute: 0,
                                          ),
                                          initialValue: DateTime.now(),
                                          // enabled: true,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText:
                                                    "Quantity planted (in KGs)",
                                              ),
                                          name: "quantity_planted",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Quantity planted',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration: customTheme.inputDecoration3(
                                            labelText:
                                                "Expected yield (in Metric tonnes)",
                                          ),
                                          name: "expected_yield",
                                          keyboardType: TextInputType.number,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Expected yield',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.phone,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Phone number",
                                              ),
                                          name: "phone_number",
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Phone number',
                                              ),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Longitude",
                                              ),
                                          readOnly: true,
                                          onTap: () {
                                            pick_gps();
                                          },
                                          // textCapitalization:
                                          //     TextCapitalization.sentences,
                                          name: "gps_longitude",
                                          minLines: 2,
                                          maxLines: 3,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Longitude',
                                              ),
                                          textInputAction:
                                              TextInputAction.newline,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          readOnly: true,
                                          onTap: () {
                                            pick_gps();
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Latitude",
                                              ),
                                          // textCapitalization:
                                          //     TextCapitalization.sentences,
                                          name: "gps_latitude",
                                          minLines: 2,
                                          maxLines: 3,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Latitude',
                                              ),
                                          textInputAction:
                                              TextInputAction.newline,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.multiline,
                                          decoration: customTheme
                                              .inputDecoration3(
                                                labelText: "Detail",
                                              ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "detail",
                                          minLines: 3,
                                          maxLines: 6,
                                          validator:
                                              MyWidgets.my_validator_field_required(
                                                context,
                                                'Detail',
                                              ),
                                          textInputAction:
                                              TextInputAction.newline,
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
                                addPlantingReturn.crop =
                                    _fKey.currentState?.fields['crop']?.value;
                                addPlantingReturn.variety = _fKey
                                    .currentState
                                    ?.fields['variety']
                                    ?.value
                                    .toString();
                                addPlantingReturn.seedClass = _fKey
                                    .currentState
                                    ?.fields['seed_class']
                                    ?.value;
                                addPlantingReturn.size = int.parse(
                                  _fKey.currentState?.fields['size']?.value,
                                );
                                addPlantingReturn.name =
                                    _fKey.currentState?.fields['name']?.value;
                                addPlantingReturn.district = _fKey
                                    .currentState
                                    ?.fields['district']
                                    ?.value;
                                addPlantingReturn.subcounty = _fKey
                                    .currentState
                                    ?.fields['subcounty']
                                    ?.value;
                                addPlantingReturn.plantingDate = _fKey
                                    .currentState
                                    ?.fields['planting_date']
                                    ?.value
                                    .toString();

                                addPlantingReturn.quantityPlanted = int.parse(
                                  _fKey
                                      .currentState
                                      ?.fields['quantity_planted']
                                      ?.value,
                                );

                                addPlantingReturn.phoneNumber = _fKey
                                    .currentState
                                    ?.fields['phone_number']
                                    ?.value;

                                addPlantingReturn.gpsLatitude = _fKey
                                    .currentState
                                    ?.fields['gps_latitude']
                                    ?.value;

                                addPlantingReturn.gpsLongitude = _fKey
                                    .currentState
                                    ?.fields['gps_longitude']
                                    ?.value;
                                addPlantingReturn.detail =
                                    _fKey.currentState?.fields['detail']?.value;
                                addPlantingReturn.village = _fKey
                                    .currentState
                                    ?.fields['village']
                                    ?.value;

                                addPlantingReturn.expectedYield = int.parse(
                                  _fKey
                                      .currentState
                                      ?.fields['expected_yield']
                                      ?.value,
                                );
                                addPlantingReturn.fieldName = _fKey
                                    .currentState
                                    ?.fields['field_name']
                                    ?.value;
                                addPlantingReturn.administratorId =
                                    locator<UserController>().user?.id;

                                model.submitPlantingReturn(addPlantingReturn, context);
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
