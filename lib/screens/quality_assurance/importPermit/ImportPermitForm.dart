import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';

class ImportPermitForm extends StatefulWidget {
  const ImportPermitForm({super.key});

  @override
  State<ImportPermitForm> createState() => ImportPermitFormState();
}

late CustomTheme customTheme;

class ImportPermitFormState extends State<ImportPermitForm> {
  final _fKey = GlobalKey<FormBuilderState>();

  AddQualityAssuranceForm addImportPermit = AddQualityAssuranceForm();
  QualityAssuaranceController qualityAssuaranceController =
      QualityAssuaranceController();

  bool isCropVariety = false;
  List<Map<String, dynamic>> selectedVarieties = [];
  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    qualityAssuaranceController.init();
    super.initState();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();

    return ChangeNotifierProvider.value(
      value: qualityAssuaranceController,
      child: Consumer<QualityAssuaranceController>(
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
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Import Permit',
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
                              )),
                        ),
                ],
              ),
            ),
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return FormBuilder(
                            key: _fKey,
                            child: Container(
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
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "name",
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
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Postal Address",
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "address",
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Address'),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.phone,
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Phone number",
                                          ),
                                          name: "telephone",
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Phone number'),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderDropdown(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Application category",
                                          ),
                                          name: "type",
                                          dropdownColor: Colors.white,
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Category '),
                                          items: AppConfig
                                              .exportPermitFormCategories
                                              .map(
                                                  (options) => DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                              .toList(),
                                        ),

                                        const SizedBox(height: 10),
                                        FormBuilderDropdown(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Country of origin",
                                          ),
                                          name: "name_address_of_origin",
                                          dropdownColor: Colors.white,
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Category'),
                                          items: AppConfig.countriesList
                                              .map(
                                                  (options) => DropdownMenuItem(
                                                        value: options['name'],
                                                        child: Text(
                                                            options['name']
                                                                .toString()),
                                                      ))
                                              .toList(),
                                        ),
                                        const SizedBox(height: 10),

                                        FormBuilderTextField(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Location of the store",
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "store_location",
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Store Location'),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Name of supplier",
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "supplier_name",
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Name of supplier'),
                                          textInputAction: TextInputAction.next,
                                        ),
                                        FormBuilderTextField(
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText:
                                                "Quantity of seed of the same variety held in stock (metric tons)",
                                          ),
                                          name: "quantiry_of_seed",
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'Quantity of seed'),
                                          textInputAction: TextInputAction.next,
                                        ),

                                        const SizedBox(height: 10),
                                        FormBuilderTextField(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText: "Address of supplier",
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          name: "supplier_address",
                                          textInputAction: TextInputAction.next,
                                        ),

                                        FormBuilderDropdown(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText:
                                                "The seed consignment shall be accompanied by",
                                          ),
                                          name: "ista_certificate",
                                          dropdownColor: Colors.white,
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'This field '),
                                          items: [
                                            'ISTA certificate',
                                            'Phytosanitary certificate',
                                          ]
                                              .map(
                                                  (options) => DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                              .toList(),
                                        ),
                                        FormBuilderDropdown(
                                          decoration:
                                              customTheme.inputDecoration3(
                                            labelText:
                                                "Phytosanitary certificate",
                                          ),
                                          name: "phytosanitary_certificate",
                                          dropdownColor: Colors.white,
                                          validator: MyWidgets
                                              .my_validator_field_required(
                                                  context, 'This field '),
                                          items: [
                                            'Yes',
                                            'No',
                                          ]
                                              .map(
                                                  (options) => DropdownMenuItem(
                                                        value: options,
                                                        child: Text(options),
                                                      ))
                                              .toList(),
                                        ),

                                        const SizedBox(height: 10),
                                        //add ISTA certificate and Phytosanitary certificate here
                                        FxText(
                                          'I/We wish to apply for a license to import seed as indicated below',
                                          textAlign: TextAlign.start,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 10),

                                        Column(
                                          children: List.generate(
                                            selectedVarieties.length,
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
                                                          color:
                                                              MyColors.primary,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(5),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                "Category: ${selectedVarieties[index]['category']} ",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                "Weight: ${selectedVarieties[index]['weight']} ",
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
                                                                selectedVarieties
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
                                                              child: const Icon(
                                                                Icons.close,
                                                                size: 8,
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
                                        GestureDetector(
                                          onTap: () => {
                                            setState(() {
                                              isCropVariety = !isCropVariety;
                                            }),
                                          },
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: const BoxDecoration(
                                                color: MyColors.primary,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              height: 40,
                                              width: 170,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: FxText(
                                                      "Add Crop varieties",
                                                      fontWeight: 800,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        if (isCropVariety)
                                          FormBuilderDropdown(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText: "Select Crop variety",
                                            ),
                                            name: "crop_variety_id",
                                            dropdownColor: Colors.white,
                                            validator: MyWidgets
                                                .my_validator_field_required(
                                                    context,
                                                    'Import Category '),
                                            items: model.cropVarieties
                                                .map(
                                                  (options) => DropdownMenuItem(
                                                    value: options.id,
                                                    child: Text(options.name
                                                        .toString()),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        const SizedBox(height: 10),
                                        if (isCropVariety)
                                          FormBuilderTextField(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Specify other varieties. (If varieties you are applying for were not listed)",
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "other_varieties",
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (isCropVariety)
                                          FormBuilderDropdown(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText: "Import Crop category",
                                            ),
                                            name: "category",
                                            dropdownColor: Colors.white,
                                            validator: MyWidgets
                                                .my_validator_field_required(
                                                    context,
                                                    'Import Category '),
                                            items: AppConfig
                                                .importCropCategories
                                                .map((options) =>
                                                    DropdownMenuItem(
                                                      value: options,
                                                      child: Text(options),
                                                    ))
                                                .toList(),
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (isCropVariety)
                                          FormBuilderTextField(
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText: "Weight (kgs)",
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "weight",
                                            textInputAction:
                                                TextInputAction.next,
                                          ),

                                        const SizedBox(height: 80),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        )
                      : FxButton.block(
                          borderRadiusAll: 0,
                          onPressed: () {
                            if (isCropVariety) {
                              _fKey.currentState!.save();
                              selectedVarieties.add({
                                'category': _fKey
                                    .currentState?.fields['category']?.value,
                                'measure': 'measure',
                                'weight':
                                    _fKey.currentState?.fields['weight']?.value,
                                'crop_variety_id': 1,
                                'other_varieties': 'other_varieties'
                              });
                              setState(() {
                                isCropVariety = !isCropVariety;
                              });
                            } else {
                              if (!_fKey.currentState!.validate()) {
                                Utils.showSnackBar(
                                    "Please Check errors in the form and fix them first.",
                                    context,
                                    background_color: Colors.red);
                                return;
                              } else {
                                addImportPermit.telephone = _fKey
                                    .currentState?.fields['telephone']?.value;
                                addImportPermit.address = _fKey
                                    .currentState?.fields['address']?.value;
                                addImportPermit.storeLocation = _fKey
                                    .currentState
                                    ?.fields['store_location']
                                    ?.value;
                                addImportPermit.quantiryOfSeed = _fKey
                                    .currentState
                                    ?.fields['quantiry_of_seed']
                                    ?.value;
                                addImportPermit.supplierName = _fKey
                                    .currentState
                                    ?.fields['supplier_name']
                                    ?.value;
                                addImportPermit.name =
                                    _fKey.currentState?.fields['name']?.value;
                                addImportPermit.supplierAddress = _fKey
                                    .currentState
                                    ?.fields['supplier_address']
                                    ?.value;
                                addImportPermit.nameAddressOfOrigin = _fKey
                                    .currentState
                                    ?.fields['name_address_of_origin']
                                    ?.value;
                                addImportPermit.istaCertificate = (_fKey
                                    .currentState
                                    ?.fields['ista_certificate']
                                    ?.value);
                                addImportPermit.type =
                                    _fKey.currentState?.fields['type']?.value;
                                addImportPermit.isImport = true;
                                addImportPermit.administratorId =
                                    locator<UserController>().user?.id;
                                addImportPermit.cropVarieties =
                                    selectedVarieties;
                                model.submitImportPermitForm(addImportPermit);
                                _fKey.currentState!.reset();
                              }
                            }
                          },
                          backgroundColor: CustomTheme.primary,
                          child: FxText(
                            isCropVariety ? "Add Variety" : "SUBMIT",
                            fontSize: 18,
                            color: customTheme.cookifyOnPrimary,
                          )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
