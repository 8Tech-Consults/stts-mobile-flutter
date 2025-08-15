import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/custom_theme.dart';
import '../utils/Utils.dart';
import '../utils/my_colors.dart';

class MyWidgets {
  static Widget image_picker(
    String label,
    String local_image_path,
    Function pick_callback,
    Function remove_callback,
  ) {
    return (!local_image_path.isEmpty)
        ? Container(
            margin: EdgeInsets.only(bottom: 16),
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image.file(
                    File(local_image_path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: FxButton.text(
                      child: FxText(
                        "Remove photo",
                        fontSize: 20,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        remove_callback();
                      },
                    ))
              ],
            ),
          )
        : InkWell(
            onTap: () {
              pick_callback();
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: MyColors.primary,
                      width: 1,
                      style: BorderStyle.solid),
                  color: MyColors.primary.withAlpha(25),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 35, color: MyColors.primary),
                      Center(
                          child: FxText(
                        label,
                        fontSize: 16,
                        color: Colors.black,
                      )),
                    ])),
          );
  }

  static Widget my_empty_widget(BuildContext context, String title) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 200),
            child: FxText(
              title,
              fontSize: 24,
              fontWeight: 400,
              textAlign: TextAlign.center,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static FormFieldValidator my_validator_field_required(
      BuildContext context, String field) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        // context,
        errorText: "${field} is required.",
      ),
    ]);
  }

  static Widget single_field_widget(
    String title,
    String sub_title, {
    bool is_yes_no = false,
    bool tell_status = false,
  }) {
    if (is_yes_no) {
      if (sub_title.toString() == "1") {
        sub_title = "Yes";
      } else {
        sub_title = "No";
      }
    }

    if (sub_title == "null") {
      sub_title = "-";
    }
    return Expanded(
      child: Container(
        child: Column(
          children: [
            FxText(
              "${title}",
              fontSize: 16,
              fontWeight: 700,
              color: Colors.grey.shade900,
              height: 1,
            ),
            tell_status
                ? Utils.tell_status_widget(sub_title)
                : FxText(
                    "${sub_title}",
                    fontSize: 16,
                    height: 1,
                    fontWeight: 600,
                    color: CustomTheme.primary,
                  ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
