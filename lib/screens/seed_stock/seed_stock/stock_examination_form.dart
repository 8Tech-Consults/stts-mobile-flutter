import 'package:STTS/models/add_stock_form.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';

class StockExaminationForm extends StatefulWidget {
  final int? id;
  const StockExaminationForm({super.key, this.id});

  @override
  State<StockExaminationForm> createState() => StockExaminationFormState();
}

late CustomTheme customTheme;

class StockExaminationFormState extends State<StockExaminationForm> {
  SeedController seedController = SeedController();
  AddStockForm addStockExam = AddStockForm();

  String? selectedCategory;
  int? selectedOption;

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
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
                                                      labelText: "Seed class",
                                                    ),
                                                    name: "seed_class",
                                                    dropdownColor: Colors.white,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'This field '),
                                                    items: [
                                                      'Pre-Basic',
                                                      'Certificate seed',
                                                      'Basic seed',
                                                      'Quality declared seed',
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
                                                          "Enter seed company name",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "seed_company_name",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'seed_company_name'),
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
                                                          "Enter lot size(kgs)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "lot_size",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'lot_size'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  FormBuilderDateTimePicker(
                                                    inputType: InputType.date,
                                                    name: "date",
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    validator:
                                                        FormBuilderValidators
                                                            .compose([
                                                      FormBuilderValidators
                                                          .required(
                                                        // context,
                                                        errorText:
                                                            "Stock collection date is required",
                                                      ),
                                                    ]),
                                                    decoration: customTheme
                                                        .input_decoration_2(
                                                      labelText:
                                                          "Stock collection date",
                                                      suffixIcon: CupertinoIcons
                                                          .calendar,
                                                    ),
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText: "Enter purity",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "purity",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context, 'purity'),
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
                                                          "Enter Germination",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "germination",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'germination'),
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
                                                          "Enter moisture content",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "moisture_content",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'moisture_content'),
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
                                                          "Insect damage",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "insect_damage",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'insect_damage'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText: "Moldiness",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "moldiness",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'moldiness'),
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
                                                          "Noxious weeds",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "noxious_weeds",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'noxious_weeds'),
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
                                                          'Examination decision')),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: const Text(
                                                            'Rejected'),
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
                                                            'Accepted'),
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
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter status comment (Remarks)",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "status_comment",
                                                    minLines: 5,
                                                    maxLines: 10,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'status_comment'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
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
                                      } else {
                                        addStockExam.status = selectedOption;
                                        addStockExam.yield = int.parse(_fKey
                                            .currentState
                                            ?.fields['lot_size']
                                            ?.value);

                                        model.submitSeedExamForm(
                                          addStockExam,
                                          widget.id,
                                        );
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
