import 'package:STTS/controllers/user_controller.dart';
import 'package:STTS/injection_container.dart';
import 'package:STTS/models/inspection.dart';
import 'package:STTS/screens/quality_assurance/sr10planting_inspection/crop_inspection.dart';
import 'package:STTS/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';

class AssignedWidget extends StatelessWidget {
  final Inspection item;
  final bool isCrop;
  const AssignedWidget({super.key, required this.item, required this.isCrop});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (locator<UserController>().user?.roles[0].name != "Basic User" &&
                item.form?.status != "4") {
              Get.to(
                CropInspection(
                  inspection: item,
                  isCrop: isCrop,
                ),
              );
            }
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.form?.cropVariety?.name != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          right: 6,
                        ),
                        child: FxText(
                          "Variety: ${item.form?.cropVariety?.name}",
                          fontSize: 15,
                          height: 1.1,
                          color: Colors.grey.shade900,
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                if (item.form?.sizeOfField != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Field Size: ${item.form?.sizeOfField}",
                      fontSize: 15,
                      height: 1.1,
                      color: Colors.grey.shade900,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                if (item.subGrower?.plantingDate != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Planting Date: ${item.subGrower?.plantingDate}",
                      fontSize: 15,
                      height: 1.1,
                      color: Colors.grey.shade900,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                if (item.user != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Grower name : ${item.user}",
                      fontSize: 15,
                      height: 1.1,
                      color: Colors.grey.shade900,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (item.inspectionType != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Inpection type : ${item.inspectionType}",
                      fontSize: 15,
                      height: 1.1,
                      color: Colors.grey.shade900,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Utils.tell_status_widget(item.form!.status.toString()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[200],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
