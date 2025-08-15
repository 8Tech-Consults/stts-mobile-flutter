import '../../../Constants/stts_uganda_base_exports.dart';
import '../../../Constants/stts_uganda_exports.dart';

class SeedLabelForm extends StatefulWidget {
  const SeedLabelForm({super.key});

  @override
  State<SeedLabelForm> createState() => SeedLabelFormState();
}

late CustomTheme customTheme;

class SeedLabelFormState extends State<SeedLabelForm> {
  SeedController seedController = SeedController();
  AddSeedLabel addSeedLabel = AddSeedLabel();
  File? image;
  File? image2;

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
    seedController.fetchSeedLabelData(locator<UserController>().user?.id);
  }

  bool isDark = false;

  void showBottomSheetPhoto2(context) {
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
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        doPickImage2('camera');
                      },
                      dense: false,
                      leading:
                          const Icon(Icons.camera_alt, color: MyColors.primary),
                      title: FxText(
                        "Camera",
                        fontWeight: 600,
                        color: MyColors.primary,
                      ),
                    ),
                    ListTile(
                        dense: false,
                        onTap: () => {doPickImage2("gallery")},
                        leading: const Icon(Icons.photo_library_sharp,
                            color: MyColors.primary),
                        title: FxText(
                          "Gallery",
                          fontWeight: 600,
                          color: MyColors.primary,
                        )),
                  ],
                ),
              ),
            ),
          );
        });
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
                      topRight: Radius.circular(16))),
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
                        color: MyColors.primary,
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
                          color: MyColors.primary,
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: seedController,
      child: Consumer<SeedController>(
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
                          'Seed Label',
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
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Select lab test number",
                                              ),
                                              name: "seed_lab_id",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Select lab test number'),
                                              items: model.labtestnumbers
                                                  .map(
                                                    (options) =>
                                                        DropdownMenuItem(
                                                      value: options.id,
                                                      child: Text(
                                                          '${options.labTestNumber}'),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderDropdown(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText:
                                                    "Select Seed label package",
                                              ),
                                              name: "seed_label_package_id",
                                              dropdownColor: Colors.white,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context,
                                                      'Select Seed label package'),
                                              items: model.seedLabelsPackages
                                                  .map(
                                                    (options) =>
                                                        DropdownMenuItem(
                                                      value: options.id,
                                                      child: Text(
                                                          'Package size: ${options.packageSize} kgs @ ${options.packagePrice}'),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Quantity",
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              name: "quantity",
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Quantity'),
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(height: 10),
                                            FormBuilderTextField(
                                              decoration:
                                                  customTheme.inputDecoration3(
                                                labelText: "Remarks",
                                              ),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              name: "applicant_remarks",
                                              minLines: 2,
                                              maxLines: 3,
                                              validator: MyWidgets
                                                  .my_validator_field_required(
                                                      context, 'Remarks'),
                                              textInputAction:
                                                  TextInputAction.newline,
                                            ),
                                            const SizedBox(height: 15),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  'Select thumbnail image'),
                                            ),
                                            const SizedBox(height: 15),
                                            MyWidgets.image_picker(
                                                'Seeds photo. (To appear in market place)',
                                                image2 != null
                                                    ? image2!.path
                                                    : '',
                                                () => {
                                                      showBottomSheetPhoto2(
                                                          context)
                                                    }, () {
                                              setState(() {
                                                localImagePath2 = "";
                                              });
                                            }),
                                            const SizedBox(height: 10),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Attach receipt'),
                                            ),
                                            const SizedBox(height: 10),
                                            MyWidgets.image_picker(
                                                'Add payment receipt photo',
                                                image != null
                                                    ? image!.path
                                                    : '',
                                                () => {
                                                      showBottomSheetPhoto(
                                                          context)
                                                    }, () {
                                              setState(() {
                                                localImagePath = "";
                                              });
                                            }),
                                            const SizedBox(height: 65),
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
                                if (!_fKey.currentState!.validate()) {
                                  Utils.showSnackBar(
                                      "Please Check errors in the form and fix them first.",
                                      context,
                                      background_color: Colors.red);
                                  return;
                                } else {
                                  addSeedLabel.administratorId =
                                      locator<UserController>().user?.id;
                                  addSeedLabel.applicantRemarks = (_fKey
                                      .currentState
                                      ?.fields['applicant_remarks']
                                      ?.value);

                                  addSeedLabel.quantity = int.parse(_fKey
                                      .currentState?.fields['quantity']?.value);

                                  addSeedLabel.seedLabId = (_fKey.currentState
                                      ?.fields['seed_lab_id']?.value);
                                  addSeedLabel.seedLabelPackageId = _fKey
                                      .currentState
                                      ?.fields['seed_label_package_id']
                                      ?.value;
                                  addSeedLabel.status = 1;
                                  addSeedLabel.statusComment =
                                      "Pending approval from supervisor";
                                  addSeedLabel.image =
                                      "data:image/png;base64,${base64Encode(File(image!.path).readAsBytesSync())}";
                                  addSeedLabel.receipt =
                                      "data:image/png;base64,${base64Encode(File(image2!.path).readAsBytesSync())}";
                                  model.submitSeedLabels(addSeedLabel);
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
              ),
              future: null,
            ),
          );
        },
      ),
    );
  }

  String localImagePath = "";
  String localImagePath2 = "";

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

  doPickImage2(String source) async {
    if (source == "camera") {
      final ImagePicker _picker = ImagePicker();
      await _picker
          .pickImage(source: ImageSource.camera)
          .then((selectedImageFile) {
        setState(() {
          image2 = File(selectedImageFile!.path);
        });
      });
    } else {
      final ImagePicker _picker = ImagePicker();
      await _picker
          .pickImage(source: ImageSource.gallery)
          .then((selectedImageFile) {
        setState(() {
          image2 = File(selectedImageFile!.path);
        });
      });
    }

    setState(() {});
  }

  final _fKey = GlobalKey<FormBuilderState>();
}
