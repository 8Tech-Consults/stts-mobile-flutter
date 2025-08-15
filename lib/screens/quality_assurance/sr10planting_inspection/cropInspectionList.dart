import 'package:STTS/controllers/planting_controller.dart';
import 'package:STTS/controllers/user_controller.dart';
import 'package:STTS/injection_container.dart';
import 'package:STTS/screens/home/home_fragment.dart';
import 'package:STTS/theme/app_theme.dart';
import 'package:STTS/utils/my_colors.dart';
import 'package:STTS/widgets/assigned_widget.dart';
import 'package:STTS/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CropInspectionList extends StatefulWidget {
  String title = "Crop inspections";
  CropInspectionList({Key? key}) : super(key: key);

  @override
  State<CropInspectionList> createState() => _CropInspectionListState();
}

class _CropInspectionListState extends State<CropInspectionList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;
  PlantingController plantingController = PlantingController();
  Future<void> _onRefresh(BuildContext _context) async {
    return;
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    plantingController.fetchAssignedQDs(locator<UserController>().user?.id);
  }

  void dipose() {
    pageController.dispose();
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
                      onRefresh: _do_refresh,
                      color: CustomTheme.primary,
                      backgroundColor: Colors.white,
                      child: model.assignedQDs.isEmpty
                          ? MyWidgets.my_empty_widget(
                              context, 'You don\'t have any  crop inspections.')
                          : CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return AssignedWidget(
                                        isCrop: true,
                                        item: model.assignedQDs[index],
                                      );
                                    },
                                    childCount: model
                                        .assignedQDs.length, // 1000 list items
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

  Future<void> _do_refresh() async {
    return await _onRefresh(context);
  }
}
