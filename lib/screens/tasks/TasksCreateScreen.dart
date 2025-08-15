import '../../../screens/option_pickers/single_option_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../models/EmployeeModel.dart';
import '../../models/ProjectModel.dart';
import '../../models/RespondModel.dart';
import '../../models/option_picker_model.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../../../utils/Utils.dart';

class TasksCreateScreen extends StatefulWidget {
  @override
  State<TasksCreateScreen> createState() => TasksCreateScreenState();
}

late CustomTheme customTheme;

class TasksCreateScreenState extends State<TasksCreateScreen> {
  String nature_of_off = "";

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    super.initState();
  }

  @override
  void dipose() {}

  bool isDark = false;
  bool is_loading = false;

  void do_upload_process() async {
    error_message = "";
    setState(() {});
    if (!_formKey.currentState!.validate()) {
      Utils.showSnackBar(
          "Please Check errors in the form and fix them first.", context,
          background_color: Colors.red);
      return;
    }

    Map<String, dynamic> form_data_map = {};
    form_data_map["assigned_to"] = assigned_to.toString();
    form_data_map["project_id"] = project_id.toString();
    form_data_map["name"] = _formKey.currentState?.fields['title']?.value;
    form_data_map["task_date"] =
        _formKey.currentState?.fields['task_date']?.value;
    form_data_map["start_time"] =
        _formKey.currentState?.fields['start_time']?.value;
    form_data_map["end_time"] =
        _formKey.currentState?.fields['end_time']?.value;
    form_data_map["body"] = _formKey.currentState?.fields['body']?.value;
    is_loading = true;
    setState(() {});

    RespondModel resp =
        RespondModel(await Utils.http_post('api/tasks', form_data_map));

    is_loading = false;
    setState(() {});
    if (resp.code != 1) {
      error_message = resp.message;
      Utils.showSnackBar(resp.message, context, background_color: Colors.red);
      return;
    }

    Navigator.pop(context, {"task": 'success'});
    Utils.showSnackBar(resp.message, context, background_color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    Utils.init_theme();

    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomTheme.bg_primary_light,
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
                    child: Icon(
                      CupertinoIcons.clear,
                      size: 20,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      'Add task',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: 500,
                    ),
                  ],
                ),
              ),
              Expanded(child: Text("")),
              (is_loading)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        do_upload_process();
                      },
                      child: Container(
                          padding: FxSpacing.x(10),
                          child: Icon(
                            CupertinoIcons.check_mark,
                            size: 25,
                          )),
                    ),
            ],
          ),
        ),
        body: FormBuilder(
          key: _formKey,
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
                                padding: EdgeInsets.only(
                                  left: 15,
                                  top: 5,
                                  right: 15,
                                ),
                                child: Column(
                                  children: [
                                    FormBuilderTextField(
                                        onTap: () => {pick_employee()},
                                        readOnly: true,
                                        name: "assigned_to_text",
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                            // context,
                                            errorText:
                                                "Person assigned to is required",
                                          ),
                                        ]),
                                        decoration:
                                            customTheme.input_decoration_2(
                                          labelText: "Task assigned to",
                                          suffixIcon:
                                              CupertinoIcons.right_chevron,
                                        )),
                                    FormBuilderTextField(
                                        onTap: () => {pick_project()},
                                        readOnly: true,
                                        name: "project_text",
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                            // context,
                                            errorText: "Project is required",
                                          ),
                                        ]),
                                        decoration: customTheme.input_decoration_2(
                                            labelText: "Project",
                                            suffixIcon:
                                                CupertinoIcons.right_chevron,
                                            hintText:
                                                "Project related to this task")),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, top: 10),
                                      child: FxDashedDivider(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    FormBuilderTextField(
                                        name: "title",
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                            // context,
                                            errorText:
                                                "Task title is required.",
                                          ),
                                          FormBuilderValidators.minLength(
                                            // context,
                                            2,
                                            errorText: "Title too short.",
                                          ),
                                          FormBuilderValidators.maxLength(
                                            // context,
                                            45,
                                            errorText: "Title too long.",
                                          ),
                                        ]),
                                        decoration: customTheme.input_decoration_2(
                                            labelText: "Task title",
                                            hintText:
                                                "Briefly describe this task?")),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FormBuilderDateTimePicker(
                                        inputType: InputType.date,
                                        name: "task_date",
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                            // context,
                                            errorText: "Date is required",
                                          ),
                                        ]),
                                        decoration:
                                            customTheme.input_decoration_2(
                                          labelText: "Date",
                                          suffixIcon: CupertinoIcons.calendar,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FormBuilderDateTimePicker(
                                              inputType: InputType.time,
                                              name: "start_time",
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.name,
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                  // context,
                                                  errorText:
                                                      "Start time required",
                                                ),
                                              ]),
                                              decoration: customTheme
                                                  .input_decoration_2(
                                                labelText: "Start time",
                                                suffixIcon:
                                                    CupertinoIcons.chevron_down,
                                              )),
                                        ),
                                        Expanded(
                                          child: FormBuilderDateTimePicker(
                                              inputType: InputType.time,
                                              name: "end_time",
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.name,
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                  // context,
                                                  errorText:
                                                      "End time required",
                                                ),
                                              ]),
                                              decoration: customTheme
                                                  .input_decoration_2(
                                                labelText: "End time",
                                                suffixIcon:
                                                    CupertinoIcons.chevron_down,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FxDashedDivider(
                                      color: Colors.grey.shade300,
                                    ),
                                    FormBuilderTextField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        name: "body",
                                        minLines: 2,
                                        maxLines: 4,
                                        textInputAction:
                                            TextInputAction.newline,
                                        keyboardType: TextInputType.multiline,
                                        decoration: customTheme.input_decoration_2(
                                            labelText: "Task description",
                                            hintText:
                                                "Write some details about this task")),
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
                child: (is_loading)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
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
                          //showMyDialog(context);
                          do_upload_process();
                        },
                        backgroundColor: CustomTheme.primary,
                        child: FxText(
                          "ADD TASK",
                          fontSize: 18,
                          color: customTheme.cookifyOnPrimary,
                        )),
              )
            ],
          ),
        ),
      );
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();
  String error_message = "";

  String project_id = "";
  String assigned_to = "";
  String project_text = "";
  String location_sub_name = "";
  String location_id = "";
  bool is_uploading = false;

  pick_project() async {
    if (is_loading) {
      return;
    }

    setState(() {
      is_loading = true;
    });

    List<ProjectModel> items = await ProjectModel.get_items();
    List<OptionPickerModel> local_items = [];
    items.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = "1";
      item.id = element.id.toString();
      item.name = element.name.toString();
      local_items.add(item);
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SingleOptionPicker("Select project", local_items, [], false)),
    );
    setState(() {
      is_loading = false;
    });
    if (result != null) {
      if ((result['id'] != null) && (result['text'] != null)) {
        project_id = result['id'];
        _formKey.currentState!.patchValue({
          'project_text': result['text'],
        });
        setState(() {});
      }
    }
  }

  pick_employee() async {
    if (is_loading) {
      return;
    }
    setState(() {
      is_loading = true;
    });

    List<EmployeeModel> items = await EmployeeModel.get_items();
    List<OptionPickerModel> local_items = [];
    items.forEach((element) {
      OptionPickerModel item = new OptionPickerModel();
      item.parent_id = "1";
      item.id = element.id.toString();
      item.name = element.name.toString();
      local_items.add(item);
    });

    setState(() {
      is_loading = false;
    });
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SingleOptionPicker("Select a person", local_items, [], false)),
    );
    if (result != null) {
      if ((result['id'] != null) && (result['text'] != null)) {
        project_id = result['id'];
        assigned_to = result['id'];
        _formKey.currentState!.patchValue({
          'assigned_to_text': result['text'],
        });
        setState(() {});
      }
    }
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
