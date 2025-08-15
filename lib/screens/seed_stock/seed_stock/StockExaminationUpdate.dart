import 'package:STTS/models/ExportPermitModel.dart';
import 'package:STTS/models/FormStockExaminationRequestModel.dart';
import 'package:STTS/models/PlantingReturnModel.dart';
import 'package:STTS/models/add_stock_exam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:provider/provider.dart';

import '../../../Constants/stts_uganda_exports.dart';
import '../../../controllers/seed_controller.dart';
import '../../../models/LoggedInUserModel.dart';
import '../../../models/RespondModel.dart';
import '../../../models/SeedLabelModel.dart';
import '../../../models/option_picker_model.dart';
import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/Utils.dart';
import '../../../widgets/my_widgets.dart';
import '../../option_pickers/single_option_picker.dart';

class StockExaminationUpdateForm extends StatefulWidget {
  const StockExaminationUpdateForm({super.key});

  @override
  State<StockExaminationUpdateForm> createState() =>
      StockExaminationUpdateFormState();
}

late CustomTheme customTheme;

class StockExaminationUpdateFormState
    extends State<StockExaminationUpdateForm> {
  SeedController seedController = SeedController();
  AddStockExam addStockExam = AddStockExam();

  String? selectedCategory;

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
  }

  @override
  void dipose() {}

  bool isDark = false;

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
                          'Stock examination update request',
                          color: Colors.white,
                          fontSize: 15,
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
                                                    FormBuilderTextField(
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      name:
                                                          "planting_return_text",
                                                      readOnly: true,
                                                      minLines: 2,
                                                      maxLines: 5,
                                                      onTap: () {},
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText:
                                                            "Select Import Permit",
                                                      ),
                                                    ),
                                                  if (_fKey
                                                          .currentState
                                                          ?.fields[
                                                              'examination_category']
                                                          ?.value ==
                                                      "Grower seed")
                                                    FormBuilderTextField(
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      name:
                                                          "planting_return_text",
                                                      readOnly: true,
                                                      minLines: 2,
                                                      maxLines: 5,
                                                      onTap: () {},
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText:
                                                            "Select Planting return",
                                                      ),
                                                    ),
                                                  if (_fKey
                                                          .currentState
                                                          ?.fields[
                                                              'examination_category']
                                                          ?.value ==
                                                      "QDs")
                                                    FormBuilderTextField(
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      name:
                                                          "planting_return_text",
                                                      readOnly: true,
                                                      minLines: 2,
                                                      maxLines: 5,
                                                      onTap: () {},
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: customTheme
                                                          .inputDecoration3(
                                                        labelText: "Select QDs",
                                                      ),
                                                    ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  FormBuilderDropdown(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Select crop variety",
                                                    ),
                                                    name:
                                                        "examination_categoriy",
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
                                        addStockExam.cropVarietyId = 987;
                                        addStockExam.importExportPermitId = 40;
                                        addStockExam.remarks = "Some remarks";
                                        model.submitSeedExam(addStockExam);
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
