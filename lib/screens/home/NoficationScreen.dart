import 'package:STTS/models/QDSModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../models/menu_item_1.dart';
import '../../utils/app_config.dart';
import '../../models/FormSr4Model.dart';
import '../../models/FormSr6Model.dart';
import '../../models/option_picker_model.dart';
import '../../theme/app_notifier.dart';
import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../../utils/Utils.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

late CustomTheme customTheme;

class NotificationScreenState extends State<NotificationScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

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

  List<MenuItem1> items = [];

  Future<Null> _onRefresh(BuildContext _context) async {
    items.clear();
    //add list items

    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: _do_refresh,
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: CustomTheme.primary,
                toolbarHeight: 90,
                titleSpacing: 0,
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0, top: 20),
                      child: FxText(
                        "Notifications",
                        color: Colors.white,
                        fontSize: 23,
                        height: 1,
                        fontWeight: 800,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      height: 5,
                      color: Colors.black,
                    ),
                    Container(
                      height: 5,
                      color: Colors.yellow,
                    ),
                    Container(
                      height: 5,
                      color: Colors.red,
                    ),
                  ],
                ),
                floating: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                        ),
                        ListTile(
                          leading: Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          trailing: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Icon(Icons.search, color: Colors.black,)
                          ),
                        ),
                       SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15,),
                            Text("Earlier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)

                          ],
                        ),
                        Card(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                            title: Text("Notification Title"),
                            subtitle: Text('my notification details'),
                            trailing: Icon(Icons.menu),
                          ) ],
                        )),
                        Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Notification Title"),
                                  subtitle: Text('my notification details'),
                                  trailing: Icon(Icons.menu),
                                ) ],
                            )),
                        Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Notification Title"),
                                  subtitle: Text('my notification details'),
                                  trailing: Icon(Icons.menu),
                                ) ],
                            )),
                        Card(
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Notification Title"),
                                  subtitle: Text('my notification details'),
                                  trailing: Icon(Icons.menu),
                                ) ],
                            )),
                        Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Notification Title"),
                                  subtitle: Text('my notification details'),
                                  trailing: Icon(Icons.menu),
                                ) ],
                            )),
                        Card(
                                color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Notification Title"),
                                  subtitle: Text('my notification details'),

                                  trailing:  PopupMenuButton<int>(
                                    onSelected: (x) {
                                      if (x == 0) {
                                        Utils.showConfirmDialog(context, () {
                                          //onconfirm
                                          //do_delete(item.id);
                                        }, () {
                                          //on cancel
                                        },
                                            message: "Are you sure you want to delete this Notification?",
                                            positive_text: "Delete");
                                      } else {

                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(value: 1, child: Text('Mark as read')),
                                      PopupMenuItem(
                                          value: 0,
                                          onTap: () {},
                                          child: FxText(
                                            'Delete',
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ) ],
                            )),





                      ],
                    );
                  },
                  childCount: 1, // 1000 list items
                ),
              ),


            ],
          ),
        )),
      );
    });
  }

  List<FormSr4Model> sr4s = [];
  List<FormSr6Model> sr6s = [];
  List<QDSModel> qds = [];

  Future<Null> _do_refresh() async {
    qds = await QDSModel.get_items();
    return await _onRefresh(context);
  }




  Future<void> pick_location(OptionPickerModel item) async {
    List<OptionPickerModel> next_items = [];
  }
}
