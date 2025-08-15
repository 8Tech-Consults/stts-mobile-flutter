import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/add_crop_declaration.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';

class CropDeclarationForm extends StatefulWidget {
  const CropDeclarationForm({super.key});

  @override
  State<CropDeclarationForm> createState() => CropDeclarationFormState();
}

late CustomTheme customTheme;

class CropDeclarationFormState extends State<CropDeclarationForm> {
  PlantingController plantingController = PlantingController();
  AddCropDeclaration addCropDeclaration = AddCropDeclaration();
  List<Map<String, dynamic>> selectedVarieties = [];
  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
    plantingController.init();
  }

  @override
  void dipose() {
    plantingController.dispose();
  }

  bool isCropVariety = false;

  bool isDark = false;

  final _fKey = GlobalKey<FormBuilderState>();

  Future<bool> initForm() async {
    return true;
  }

  File? image;

  doPickImage(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      await _picker
          .pickImage(source: ImageSource.camera)
          .then((selectedImageFile) {
        setState(() {
          image = File(selectedImageFile!.path);
        });
      });
    } else {
      final ImagePicker _picker = ImagePicker();
      await _picker
          .pickImage(source: ImageSource.gallery)
          .then((selectedImageFile) {
        setState(() {
          image = File(selectedImageFile!.path);
        });
      });
    }

    setState(() {});
  }

  void showBottomSheetPhoto(context) {
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
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        doPickImage('camera');
                      },
                      dense: false,
                      leading:
                          const Icon(Icons.camera_alt, color: MyColors.primary),
                      title: FxText(
                        "Camera",
                        fontWeight: 600,
                        style: const TextStyle(color: MyColors.primary),
                      ),
                    ),
                    ListTile(
                      dense: false,
                      onTap: () => {doPickImage("gallery")},
                      leading: const Icon(Icons.photo_library_sharp,
                          color: MyColors.primary),
                      title: FxText(
                        "Gallery",
                        fontWeight: 600,
                        style: const TextStyle(color: MyColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          'Crop Declaration',
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
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "source_of_seed",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Enter source of seed'),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Seed Source",
                                              )),
                                          const SizedBox(height: 10),
                                          FormBuilderTextField(
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Enter field size (in Acres)",
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "field_size",
                                            minLines: 2,
                                            maxLines: 3,
                                            validator: MyWidgets
                                                .my_validator_field_required(
                                                    context, 'Size'),
                                            textInputAction:
                                                TextInputAction.newline,
                                          ),
                                          const SizedBox(height: 10),
                                          FormBuilderTextField(
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText: "Enter Seed rate",
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "seed_rate",
                                            minLines: 2,
                                            maxLines: 3,
                                            validator: MyWidgets
                                                .my_validator_field_required(
                                                    context, 'Seed Rate'),
                                            textInputAction:
                                                TextInputAction.newline,
                                          ),
                                          /*SizedBox(height: 10),
                                              FxText(
                                                'Click on "NEW" to add Crop varieties',
                                                textAlign: TextAlign.start,
                                              ),*/
                                          const SizedBox(height: 10),
                                          FormBuilderTextField(
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                customTheme.inputDecoration3(
                                              labelText:
                                                  "Enter the amount enclosed",
                                            ),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            name: "amount",
                                            minLines: 2,
                                            maxLines: 3,
                                            validator: MyWidgets
                                                .my_validator_field_required(
                                                    context, 'Amount'),
                                            textInputAction:
                                                TextInputAction.newline,
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
                                                                  "Crop variety Id: ${selectedVarieties[index]['crop_variety_id']} ",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
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
                                          const SizedBox(height: 10),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          if (isCropVariety)
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Select Crop variety",
                                              ),
                                              name: "crop_variety_id",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Crop Category '),
                                              items: model.cropVarieties
                                                  .map(
                                                    (options) =>
                                                        DropdownMenuItem(
                                                      value: options.id,
                                                      child: Text(options.name
                                                          .toString()),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          MyWidgets.image_picker(
                                              'Add payment receipt photo',
                                              image != null ? image!.path : '',
                                              () => {
                                                    showBottomSheetPhoto(
                                                        context)
                                                  }, () {
                                            setState(() {
                                              //image!.path = "";
                                            });
                                          }),
                                          SizedBox(height: 10),
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
                              if (isCropVariety) {
                                _fKey.currentState!.save();
                                selectedVarieties.add({
                                  'crop_variety_id': _fKey.currentState
                                      ?.fields['crop_variety_id']?.value,
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
                                  addCropDeclaration.administratorId =
                                      locator<UserController>().user?.id;
                                  addCropDeclaration.amount = int.parse(_fKey
                                      .currentState?.fields['amount']?.value);
                                  addCropDeclaration.seedRate = int.parse(_fKey
                                      .currentState
                                      ?.fields['seed_rate']
                                      ?.value);
                                  addCropDeclaration.fieldSize = int.parse(_fKey
                                      .currentState
                                      ?.fields['field_size']
                                      ?.value);
                                  addCropDeclaration.formQdId = 1;
                                  addCropDeclaration.sourceOfSeed = _fKey
                                      .currentState
                                      ?.fields['source_of_seed']
                                      ?.value;
                                  addCropDeclaration.status = "pending";
                                  addCropDeclaration.paymentReceipt =
                                      "data:image/png;base64,${base64Encode(File(image!.path).readAsBytesSync())}";
                                  addCropDeclaration.cropVarieties =
                                      selectedVarieties;
                                  model.submitCropDeclaration(
                                      addCropDeclaration);
                                  _fKey.currentState!.reset();
                                }
                              }
                            },
                            backgroundColor: CustomTheme.primary,
                            child: FxText(
                              isCropVariety ? "Add Variety" : "SUBMIT",
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
}
