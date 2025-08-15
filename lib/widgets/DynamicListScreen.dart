import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/option_picker_model.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../../../utils/my_colors.dart';

class DynamicListScreen extends StatefulWidget {
  List<OptionPickerModel> items;

  DynamicListScreen(this.items);

  @override
  State<DynamicListScreen> createState() => DynamicListScreenState();
}

late CustomTheme customTheme;

class DynamicListScreenState extends State<DynamicListScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  void dipose() {
    pageController.dispose();
  }

  bool is_loading = false;

  Future<Null> _onRefresh(BuildContext _context) async {
    is_loading = true;
    setState(() {});

    return null;
  }

  bool search_form_is_open = false;
  TextEditingController search_controler = new TextEditingController();
  var seachrFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SingleProduct(ready_items[index]);
              },
              childCount: ready_items.length, // 1000 list items
            ),
          )
        ],
      );
    });
  }

  List<OptionPickerModel> ready_items = [];
  String search_keyword = "";

  SingleProduct(OptionPickerModel item) {
    return ListTile(
      dense: true,
      title: FxText(item.name, fontWeight: 600, fontSize: 18),
      onTap: () {},
      trailing: item.selected
          ? Icon(
              Icons.check,
              size: 25,
              color: CustomTheme.primary,
            )
          : SizedBox(),
    );
  }
}
