import 'package:STTS/models/assigned_sub_grower.dart';
import 'package:STTS/models/inspection.dart';
import 'package:STTS/screens/quality_assurance/planting_return/initialize_planting_form.dart';
import 'package:get/get.dart';
import '../Constants/stts_uganda_exports.dart';
import '../screens/quality_assurance/sr10planting_inspection/crop_inspection.dart';

class InspectionWidget extends StatelessWidget {
  final AssignedInpection item;
  const InspectionWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (locator<UserController>().user?.roles[0].name ==
                    "Inspector")
          InkWell(
            onTap: () {
              Get.to(InitializePlantingReturnForm(
                assignedInpection: item,
              ));
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          right: 6,
                        ),
                        child: FxText(
                          "Variety: ${item.assignedSubGrower?.variety}",
                          fontSize: 15,
                          height: 1.1,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => {
                              MapUtils.openMap(
                                  double.parse(item.assignedSubGrower!.gpsLatitude
                                      .toString()),
                                  double.parse(item
                                      .assignedSubGrower!.gpsLongitude
                                      .toString())),
                            },
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (item.assignedSubGrower?.size != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                        right: 6,
                      ),
                      child: FxText(
                        "Field Size: ${item.assignedSubGrower?.size}",
                        fontSize: 15,
                        height: 1.1,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (item.assignedSubGrower?.plantingdate != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                        right: 6,
                      ),
                      child: FxText(
                        "Planting Date: ${item.assignedSubGrower?.plantingdate}",
                        fontSize: 15,
                        height: 1.1,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Grower name : ${item.assignedSubGrower?.name}",
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
                    child: Utils.tell_status_widget(
                        item.assignedSubGrower!.status.toString()),
                  ),
                ],
              ),
            ),
          ),
        if (locator<UserController>().user?.roles[0].name ==
                    "Basic User")
          Container(
            width: (MediaQuery.of(context).size.width - 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                        right: 6,
                      ),
                      child: FxText(
                        "Variety: ${item.assignedSubGrower?.variety}",
                        fontSize: 15,
                        height: 1.1,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => {
                            MapUtils.openMap(
                                double.parse(item.assignedSubGrower!.gpsLatitude
                                    .toString()),
                                double.parse(item
                                    .assignedSubGrower!.gpsLongitude
                                    .toString())),
                          },
                          icon: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                if (item.assignedSubGrower?.size != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Field Size: ${item.assignedSubGrower?.size}",
                      fontSize: 15,
                      height: 1.1,
                      color: Colors.grey.shade900,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                if (item.assignedSubGrower?.plantingdate != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Planting Date: ${item.assignedSubGrower?.plantingdate}",
                      fontSize: 15,
                      height: 1.1,
                      color: Colors.grey.shade900,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: FxText(
                    "Grower name : ${item.assignedSubGrower?.name}",
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
                  child: Utils.tell_status_widget(
                      item.assignedSubGrower!.status.toString()),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
