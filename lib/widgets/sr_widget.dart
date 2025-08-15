import 'package:STTS/Constants/stts_uganda_exports.dart';

class SrWidget extends StatelessWidget {
  final SrModel? item;
  const SrWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Utils.navigate_to(AppConfig.DetailsScreen, context,
            //     data: item.get_details());
          },
          child: Container(
            width: (size.width - 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item?.nameOfApplicant != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Text('Name of applicant:'),
                          const SizedBox(
                            width: 10,
                          ),
                          FxText(
                            "${item?.nameOfApplicant}",
                            fontSize: 20,
                            height: 1.1,
                            color: Colors.grey.shade900,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (item?.type != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Text('Type:'),
                            const SizedBox(
                              width: 10,
                            ),
                            FxText(
                              "${item?.type}",
                              fontSize: 15,
                              height: 1.1,
                              color: Colors.grey.shade900,
                            ),
                          ],
                        )),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Row(
                    children: [
                      const Text('Status:'),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, top: 0),
                        child: Utils.tell_status_widget(
                          item!.status.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Text('Date:'),
                          const SizedBox(
                            width: 10,
                          ),
                          FxText(
                            "${item?.createdAt}",
                            fontSize: 15,
                            height: 1.1,
                            color: Colors.grey.shade900,
                          ),
                        ],
                      )),
                ),
                if (item?.statusComment != null && item?.status == "4" ||
                    item?.status == "3")
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Text('Reason:'),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width / 1.6,
                              child: FxText(
                                "${item?.statusComment}",
                                fontSize: 12,
                                height: 1.1,
                                color: Colors.grey.shade900,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                  ),
                if (item?.status == "5")
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            if (item?.seedBoardRegistrationNumber != null)
                              const Text('SB Reg No:'),
                            if (item?.growerNumber != null)
                              const Text('Grower No:'),
                            const SizedBox(
                              width: 10,
                            ),
                            FxText(
                              "${item?.seedBoardRegistrationNumber ?? item?.growerNumber}",
                              fontSize: 15,
                              height: 1.1,
                              color: Colors.grey.shade900,
                            ),
                          ],
                        )),
                  ),
              ],
            ),
          ),
        ),
        Container(
          child: PopupMenuButton<int>(
            onSelected: (x) {
              if (x == 0) {
                // Utils.showConfirmDialog(context, () {
                //   //onconfirm
                //   // do_delete(item.id);
                // }, () {
                //   //on cancel
                // },
                //     message: "Are you sure you want to delete this form?",
                //     positive_text: "Delete");
              } else if (x == 1) {
                // Utils.launchURL(
                //     AppConfig.DASHBOARD_URL + "/form-sr4s/${item.id}");
              } else if (x == 3) {
                // Utils.navigate_to(AppConfig.DetailsScreen, context,
                //     data: item.get_details());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 3,
                  child: FxText(
                    'View details',
                  )),
              const PopupMenuItem(value: 1, child: Text('View on web')), //done
              PopupMenuItem(
                  enabled: Utils.is_deletable(item!.status.toString()),
                  value: 0,
                  onTap: () {
                    print("romina");
                  },
                  child: FxText(
                    'Delete',
                    color: (!Utils.is_deletable(item!.status.toString()))
                        ? Colors.grey.shade300
                        : Colors.red,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
