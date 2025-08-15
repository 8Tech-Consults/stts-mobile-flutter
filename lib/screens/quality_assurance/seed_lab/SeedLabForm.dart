import 'package:STTS/models/FormStockExaminationRequestModel.dart';
import 'package:STTS/models/add_seed_lab.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/stts_uganda_exports.dart';
import '../../../models/SeedLabelModel.dart';
import '../../../models/option_picker_model.dart';
import '../../option_pickers/single_option_picker.dart';

class SeedLabForm extends StatefulWidget {
  const SeedLabForm({super.key});

  @override
  State<SeedLabForm> createState() => SeedLabFormState();
}

late CustomTheme customTheme;

class SeedLabFormState extends State<SeedLabForm> {
  SeedController seedController = SeedController();
  AddSeedLab addSeedLab = AddSeedLab();
  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
    seedController.fetchUserCropVarieties();
    seedController.fetchStockExaminations(locator<UserController>().user?.id);
  }

  bool isDark = false;
  bool is_loading = false;
  bool main_loading = false;
  String selected_varieties_text = "";
  List<String> selected_varieties_ids = [];
  SeedLabelModel item = new SeedLabelModel();

  List<SeedLabelModel> seed_lab = [];

  Future<bool> init_form() async {
    return true;
  }

  List<String> examination_form = [];
  String examination_form_id = "";

  pick_crops() async {
    if (is_loading) {
      return;
    }
    setState(() {
      //is_loading = true;
    });

    List<FormStockExaminationRequestModel> items =
        await FormStockExaminationRequestModel.get_items();
    List<OptionPickerModel> local_items = [];
    items.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = "1";
      item.id = element.id.toString();
      item.name = "Examination form #" + element.id.toString();
      local_items.add(item);
    });

    examination_form.clear();

    setState(() {
      is_loading = false;
    });
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleOptionPicker(
              "Select examination form", local_items, examination_form, true)),
    );

    if (result != null) {
      if ((result['selected'] != null)) {
        String selected_crops_text = "";

        List<String> selected_items = [];

        result['selected'].map((element) {
          selected_items.add(element.toString());
        }).toList();

        bool is_first = true;

        items.forEach((element) {
          if (selected_items.contains(element.id.toString())) {
            if (is_first) {
              is_first = false;
              selected_crops_text +=
                  "Examination form #" + element.id.toString();
              examination_form_id = element.id.toString();
            } else {
              selected_crops_text += ", " + element.id.toString();
            }
          }
        });
        _fKey.currentState?.patchValue({
          'form_stock_examination_request_id': selected_crops_text,
        });

        setState(() {});
      }
    }
  }

  void do_upload_process() async {
    error_message = "";
    setState(() {});
    LoggedInUserModel u = await LoggedInUserModel.get_logged_in_user();

    if (!_fKey.currentState!.validate()) {
      Utils.showSnackBar(
          "Please Check errors in the form and fix them first.", context,
          background_color: Colors.red);
      return;
    }

    Map<String, dynamic> f = {};
    if (local_image_path.isEmpty) {
      Utils.showSnackBar("Please pick a receipt photo.", context,
          background_color: Colors.red);
      return;
    }

    if (examination_form_id.isEmpty) {
      Utils.showSnackBar("Please pick a examination form.", context,
          background_color: Colors.red);
      return;
    }
    var img = await MultipartFile.fromFile(local_image_path,
        filename: local_image_path);
    f['image'] = img;

    f["form_stock_examination_request_id"] = examination_form_id;
    f["collection_date"] = _fKey.currentState?.fields['collection_date']?.value;
    f["applicant_remarks"] =
        _fKey.currentState?.fields['applicant_remarks']?.value;

    is_loading = true;
    setState(() {});

    RespondModel resp =
        RespondModel(await Utils.http_post('seed-labs/new/', f));

    is_loading = false;
    setState(() {});

    if (resp.code != 1) {
      error_message = resp.message;
      Utils.showSnackBar(resp.message, context, background_color: Colors.red);
      return;
    }

    Navigator.pop(context);
    Utils.showSnackBar(resp.message, context, background_color: Colors.green);
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
                          'Seed Lab Form',
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
                                                  FormBuilderDropdown(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Select Stock Examination form",
                                                    ),
                                                    name:
                                                        "form_stock_examination_request_id",
                                                    dropdownColor: Colors.white,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context,
                                                            'Stock Exam '),
                                                    items: model
                                                        .stockExaminations
                                                        .where((e) =>
                                                            e.stockExamForm
                                                                ?.status ==
                                                            "5")
                                                        .map(
                                                          (options) =>
                                                              DropdownMenuItem(
                                                            value: options
                                                                .stockExamForm
                                                                ?.id,
                                                            child: Text(options
                                                                .stockExamForm!
                                                                .lotNumber
                                                                .toString()),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  FormBuilderDateTimePicker(
                                                    name: 'collection_date',
                                                    // onChanged: _onChanged,
                                                    inputType: InputType.date,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Collection date',
                                                    ),
                                                    initialTime:
                                                        const TimeOfDay(
                                                            hour: 8, minute: 0),
                                                    initialValue:
                                                        DateTime.now(),
                                                    // enabled: true,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  FormBuilderTextField(
                                                    decoration: customTheme
                                                        .inputDecoration3(
                                                      labelText:
                                                          "Enter remarks",
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    name: "applicant_remarks",
                                                    minLines: 2,
                                                    maxLines: 5,
                                                    validator: MyWidgets
                                                        .my_validator_field_required(
                                                            context, 'Remarks'),
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                  ),
                                                  SizedBox(height: 10),
                                                  MyWidgets.image_picker(
                                                      'Attach Payment receipt',
                                                      image != null
                                                          ? image!.path
                                                          : '',
                                                      () => {
                                                            _show_bottom_sheet_photo(
                                                                context)
                                                          }, () {
                                                    setState(() {
                                                      local_image_path = "";
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
                                        addSeedLab.administratorId =
                                            locator<UserController>().user?.id;
                                        addSeedLab.applicantRemarks = (_fKey
                                            .currentState
                                            ?.fields['applicant_remarks']
                                            ?.value);

                                        addSeedLab
                                                .formStockExaminationRequestId =
                                            _fKey
                                                .currentState
                                                ?.fields[
                                                    'form_stock_examination_request_id']
                                                ?.value;

                                        addSeedLab.cropVarietyId = (_fKey
                                            .currentState
                                            ?.fields['crop_variety_id']
                                            ?.value);

                                        addSeedLab.collectionDate = _fKey
                                            .currentState
                                            ?.fields['collection_date']
                                            ?.value
                                            .toString();
                                        addSeedLab.paymentReceipt =
                                            "data:image/png;base64,${base64Encode(File(image!.path).readAsBytesSync())}";
                                        model.submitSeedLab(addSeedLab);
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
  String error_message = "";

  String project_id = "";
  String assigned_to = "";
  String project_text = "";
  String location_sub_name = "";
  String location_id = "";
  bool is_uploading = false;

  String local_image_path = "";
  File? image;
  void _show_bottom_sheet_photo(context) {
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
                        do_pick_image('camera');
                      },
                      dense: false,
                      leading: Icon(Icons.camera_alt, color: MyColors.primary),
                      title: FxText(
                        "Camera",
                        fontWeight: 600,
                        style: const TextStyle(color: MyColors.primary),
                      ),
                    ),
                    ListTile(
                        dense: false,
                        onTap: () => {do_pick_image("gallery")},
                        leading: const Icon(Icons.photo_library_sharp,
                            color: MyColors.primary),
                        title: FxText(
                          "Gallery",
                          fontWeight: 600,
                          style: const TextStyle(color: MyColors.primary),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  do_pick_image(String source) async {
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

  showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _InternetCheckDialog();
        });
  }
}

class _InternetCheckDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        decoration: new BoxDecoration(
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
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: FxText("No Internet!", fontWeight: 700)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: FxText("Please turn on internet", fontWeight: 500)),
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
                    child: FxText("CREATE ANOTHER TASK",
                        fontWeight: 600,
                        letterSpacing: 0.3,
                        color: theme.colorScheme.onPrimary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
