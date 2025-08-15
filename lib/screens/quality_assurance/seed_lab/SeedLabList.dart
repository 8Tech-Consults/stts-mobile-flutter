import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/seed_lab.dart';
import 'package:STTS/screens/quality_assurance/seed_lab/lab_technician_inspection.dart';
import 'package:STTS/screens/quality_assurance/seed_lab/seed_inspection_form.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/SeedLabModel.dart';

// ignore: must_be_immutable
class SeedLabList extends StatefulWidget {
  String title = "My seed lab forms";

  SeedLabList({Key? key}) : super(key: key);

  @override
  State<SeedLabList> createState() => SeedLabListState();
}

late CustomTheme customTheme;

class SeedLabListState extends State<SeedLabList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  SeedController seedController = SeedController();

  List<SeedLabModel> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    seedController.fetchSeedLabs(locator<UserController>().user?.id);
  }

  void dipose() {
    pageController.dispose();
  }

  // ignore: non_constant_identifier_names
  bool is_loading = false;

  Future<void> _onRefresh(BuildContext _context) async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: seedController,
      child: Consumer<SeedController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CustomTheme.primary,
              elevation: .5,
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: Text(
                widget.title,
                style: const TextStyle(color: MyColors.grey_10),
              ),
              actions: [
                if (locator<UserController>().user?.roles[0].name ==
                    "Basic User")
                  InkWell(
                    onTap: () {
                      setState(() {
                        Utils.navigate_to(AppConfig.seedLabForm, context);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            body: SafeArea(
                child: model.isLoading
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
                    : RefreshIndicator(
                        onRefresh: _do_refresh,
                        color: CustomTheme.primary,
                        backgroundColor: Colors.white,
                        child: model.seedLabs.isEmpty
                            ? MyWidgets.my_empty_widget(context,
                                'You have not created any seed lab form. Press the "+" button in top right conner to create one.')
                            : CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return SingleProduct(
                                            model.seedLabs[index]);
                                      },
                                      childCount: model
                                          .seedLabs.length, // 1000 list items
                                    ),
                                  )
                                ],
                              ),
                      )),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _do_refresh() async {
    seedController.fetchSeedLabs(locator<UserController>().user?.id);

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(SeedLab item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (locator<UserController>().user?.roles[0].name == "Inspector") {
              Get.to(
                SeedLabInspectionForm(
                  seedLabId: item.id,
                ),
              );
            }
            if (locator<UserController>().user?.roles[0].name ==
                "Lab technician") {
              Get.to(
                LabTechnicianInspectionForm(
                  seedLabId: item.id,
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
                if (item.quantity != null)
                  Text(
                    "Quantity:  ${item.quantity}",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                Text(
                  "Date created:  ${DateFormat('EEEE, d MMM, yyyy').format(
                    DateTime.parse(item.createdAt.toString()),
                  )}",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  "Lot number:  ${item.lotNumber}",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 6,
                //     right: 6,
                //   ),
                //   child: FxText(
                //     "${Utils.string_parse(item.testsRequired, 'Seed lab - ${item.createdAt}')}",
                //     fontSize: 20,
                //     height: 1.1,
                //     color: Colors.grey.shade900,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Utils.tell_status_widget(item.status.toString()),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> do_delete(int id) async {
    is_loading = true;
    setState(() {});
    String raw = await Utils.http_post('seed-labs/delete', {'id': id});
    RespondModel resp = RespondModel(raw);

    is_loading = false;
    setState(() {});

    if (resp.code == 1) {
      Utils.showSnackBar(resp.message, context,
          color: Colors.white, background_color: Colors.green.shade600);
      _do_refresh();
    } else {
      Utils.showSnackBar(resp.message, context,
          color: Colors.white, background_color: Colors.red.shade600);
    }
  }
}
