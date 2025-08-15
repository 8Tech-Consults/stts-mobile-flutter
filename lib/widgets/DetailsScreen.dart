import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_notifier.dart';
import '../../../theme/app_theme.dart';
import '../models/KeyValue.dart';

class DetailsScreen extends StatefulWidget {
  String title = "Single screen details";
  dynamic data;

  DetailsScreen(this.data);

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

late CustomTheme customTheme;

class DetailsScreenState extends State<DetailsScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  List<KeyValue> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _do_refresh();
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        backgroundColor: CustomTheme.bg_primary_light,
        appBar: AppBar(
          backgroundColor: CustomTheme.primary,
          elevation: .5,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            widget.title + " ${items.length}",
          ),
        ),
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: _do_refresh,
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          child: FxCard(
            marginAll: 10,
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return SingleItem(items[index]);
                    },
                    childCount: items.length, // 1000 list items
                  ),
                )
              ],
            ),
          ),
        )),
      );
    });
  }

  Future<Null> _do_refresh() async {
    is_loading = true;
    setState(() {});

    if (this.widget.data != null) {
      if (this
          .widget
          .data
          .runtimeType
          .toString()
          .toLowerCase()
          .contains('map')) {
        if (this.widget.data['title'] != null) {
          if (this.widget.data['title'].runtimeType.toString() == 'String') {
            widget.title = this.widget.data['title'].toString();
          }
        }
        if (this.widget.data['data'] != null) {
          if (this.widget.data['data'].runtimeType.toString() ==
              'List<KeyValue>') {
            items = this.widget.data['data'];
          }
        }
      }
    }

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  SingleItem(KeyValue item) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6, top: 3),
            child: FxText(
              "${item.key}",
              height: 1.1,
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: FxText(
              "${item.value}",
              fontSize: 16,
              height: 1.1,
              color: Colors.grey.shade900,
            ),
          ),
          Divider(
            height: 10,
            color: CustomTheme.bg_primary_light,
          )
        ],
      ),
    );

    return ListTile(
      dense: true,
      title: FxText('osnakj', fontWeight: 600, fontSize: 18),
      subtitle: FxText('osnakj', fontWeight: 600, fontSize: 18),
      onTap: () {},
    );
  }
}
