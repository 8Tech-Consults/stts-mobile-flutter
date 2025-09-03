import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/models/SR10Model.dart';
import 'package:STTS/widgets/assigned_widget.dart';

// ignore: must_be_immutable
class PlantingInspectionList extends StatefulWidget {
  String title = "My plant inspections";

  PlantingInspectionList({Key? key}) : super(key: key);

  @override
  State<PlantingInspectionList> createState() => PlantingInspectionListState();
}

late CustomTheme customTheme;

class PlantingInspectionListState extends State<PlantingInspectionList> {
  PlantingController plantingController = PlantingController();

  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  List<SR10Model> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    plantingController.fetchAssignedS10s(locator<UserController>().user?.id);
  }

  void dipose() {
    pageController.dispose();
  }

  // ignore: non_constant_identifier_names
  bool is_loading = false;

  // Future<void> _onRefresh(BuildContext _context) async {
  //   return;
  // }
  Future<void> _onRefresh() async {
    return  plantingController.fetchAssignedS10s(locator<UserController>().user?.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: plantingController,
      child: Consumer<PlantingController>(
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
                style: const TextStyle(color: MyColors.grey_3),
              ),
            ),
            body: SafeArea(
              child: model.isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: CustomTheme.primary,
                      backgroundColor: Colors.white,
                      child: model.assignedS10s.isEmpty
                          ? MyWidgets.my_empty_widget(context,
                              'You don\'t have any pending plant inspections.')
                          : CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return AssignedWidget(
                                        isCrop: false,
                                        item: model.assignedS10s[index],
                                        onReload: _onRefresh
                                      );
                                    },
                                    childCount: model
                                        .assignedS10s.length, // 1000 list items
                                  ),
                                )
                              ],
                            ),
                    ),
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  // Future<void> _do_refresh() async {
  //   return await _onRefresh(context);
  // }
}
