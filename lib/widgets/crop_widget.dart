import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/crop_declaration.dart';
import 'package:STTS/screens/quality_assurance/qds_crop_declaration/initialize_form.dart';
import 'package:get/get.dart';

class CropWidget extends StatelessWidget {
  final CropDeclaration item;
  const CropWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (locator<UserController>().user?.roles[0].name == "Inspector") {
              Get.to(
                InitializeCropInspection(
                  qdsId: item.id,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "Amount: ${item.amount}",
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
                  child: Utils.tell_status_widget(item.status.toString()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "source of seed:  ${item.sourceofSeed}",
                    fontSize: 15,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "Field Size:  ${item.fieldSize}",
                    fontSize: 15,
                    height: 1.1,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
