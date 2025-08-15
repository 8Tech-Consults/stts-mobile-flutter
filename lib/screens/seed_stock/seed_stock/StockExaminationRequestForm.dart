import 'package:STTS/models/accepted_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';

class StockExaminationRequestForm extends StatefulWidget {
  const StockExaminationRequestForm({super.key});

  @override
  State<StockExaminationRequestForm> createState() =>
      StockExaminationRequestFormState();
}

late CustomTheme customTheme;

class StockExaminationRequestFormState
    extends State<StockExaminationRequestForm> {
  SeedController seedController = SeedController();
  AddStockExam addStockExam = AddStockExam();

  AcceptedModel? acceptedModel;

  String? selectedCategory;

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    seedController.init(locator<UserController>().user?.id);
    super.initState();
  }

  Future<bool> initForm() async {
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
                          'Stock examination request',
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
                future: initForm(),
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
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Select examination category",
                                                    ),
                                                    name:
                                                        "examination_category",
                                                    dropdownColor: Colors.white,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'This field '),
                                                    items: [
                                                      'Imported seed',
                                                      'Grower seed',
                                                      'QDs',
                                                    ]
                                                        .map((options) =>
                                                            DropdownMenuItem(
                                                              value: options,
                                                              child:
                                                                  Text(options),
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  if (_fKey
                                                          .currentState
                                                          ?.fields[
                                                              'examination_category']
                                                          ?.value ==
                                                      "Imported seed")
                                                    FormBuilderDropdown(
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText:
                                                            "Select Import permit",
                                                      ),
                                                      name:
                                                          "import_export_permit_id",
                                                      dropdownColor:
                                                          Colors.white,
                                                      validator: MyWidgets
                                                          .my_validator_field_required(
                                                              context,
                                                              'Select Import permit'),
                                                      items: model
                                                          .acceptedPermits
                                                          .map(
                                                            (options) =>
                                                                DropdownMenuItem(
                                                              value: options.id,
                                                              child: Text(
                                                                  "Import permit number: ${options.permitNumber.toString()}"),
                                                            ),
                                                          )
                                                          .toList(),
                                                      onChanged: (value) {
                                                        model.fetchCropVarieties(
                                                            int.parse(value
                                                                .toString()));
                                                      },
                                                    ),
                                                  if (_fKey
                                                          .currentState
                                                          ?.fields[
                                                              'examination_category']
                                                          ?.value ==
                                                      "Grower seed")
                                                    FormBuilderDropdown(
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText:
                                                            "Select approved field",
                                                      ),
                                                      name:
                                                          "planting_return_id",
                                                      dropdownColor:
                                                          Colors.white,
                                                      validator: MyWidgets
                                                          .my_validator_field_required(
                                                              context,
                                                              'Select approved field'),
                                                      items: model
                                                          .acceptedPlantingReturns
                                                          .map(
                                                            (options) =>
                                                                DropdownMenuItem(
                                                              value: options.id,
                                                              child: Text(options
                                                                  .fieldName
                                                                  .toString()),
                                                            ),
                                                          )
                                                          .toList(),
                                                      onChanged: (value) {},
                                                    ),
                                                  if (_fKey
                                                          .currentState
                                                          ?.fields[
                                                              'examination_category']
                                                          ?.value ==
                                                      "QDs")
                                                    FormBuilderDropdown(
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText:
                                                            "Select approved QDS declaration",
                                                      ),
                                                      name: "form_qds_id",
                                                      dropdownColor:
                                                          Colors.white,
                                                      validator: MyWidgets
                                                          .my_validator_field_required(
                                                              context,
                                                              'Select approved QDS declaration'),
                                                      items: model.acceptedQds
                                                          .map(
                                                            (options) =>
                                                                DropdownMenuItem(
                                                              value: options.id,
                                                              child: Text(
                                                                options
                                                                    .sr10Number
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      onChanged: (value) {
                                                        acceptedModel = model
                                                            .acceptedQds
                                                            .where((option) =>
                                                                option.id ==
                                                                value)
                                                            .lastOrNull;
                                                      },
                                                    ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  if (_fKey
                                                          .currentState
                                                          ?.fields[
                                                              'examination_category']
                                                          ?.value ==
                                                      "Imported seed")
                                                    FormBuilderDropdown(
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText:
                                                            "Select crop variety",
                                                      ),
                                                      name: "crop_variety_id",
                                                      dropdownColor:
                                                          Colors.white,
                                                      validator: MyWidgets
                                                          .my_validator_field_required(
                                                              context,
                                                              'Select crop variety'),
                                                      items: model
                                                          .acceptedCropVarieries
                                                          .map(
                                                            (options) =>
                                                                DropdownMenuItem(
                                                              value: options.id,
                                                              child: Text(
                                                                  " ${options.text.toString()}"),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  const SizedBox(height: 10),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter lot number",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "lot_number",
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter remarks",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "remarks",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context, 'Remarks'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  const SizedBox(height: 10),
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
                                      } else {
                                        addStockExam.administratorId =
                                            locator<UserController>().user?.id;
                                        addStockExam.lotNumber = _fKey
                                            .currentState
                                            ?.fields['lot_number']
                                            ?.value;

                                        addStockExam.cropVarietyId = _fKey
                                                    .currentState
                                                    ?.fields['crop_variety_id']
                                                    ?.value !=
                                                null
                                            ? int.parse(_fKey
                                                .currentState
                                                ?.fields['crop_variety_id']
                                                ?.value)
                                            : int.parse(acceptedModel!
                                                .cropVarietyId
                                                .toString());

                                        addStockExam.importExportPermitId =
                                            (_fKey
                                                .currentState
                                                ?.fields[
                                                    'import_export_permit_id']
                                                ?.value);

                                        addStockExam.plantingReturnId = (_fKey
                                            .currentState
                                            ?.fields['planting_return_id']
                                            ?.value);
                                        addStockExam.formQdsId = (_fKey
                                            .currentState
                                            ?.fields['form_qds_id']
                                            ?.value);
                                        addStockExam.remarks = _fKey
                                            .currentState
                                            ?.fields['remarks']
                                            ?.value;
                                        //  model.submitLocalSeedExam(addStockExam);
                                        model.submitSeedExam(addStockExam);
                                        _fKey.currentState!.reset();
                                      }
                                    },
                                    backgroundColor: CustomTheme.primary,
                                    child: FxText(
                                      "SUBMIT",
                                      fontSize: 18,
                                      color: customTheme.cookifyOnPrimary,
                                    ),
                                  ),
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
}
