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

class SingleOptionPicker extends StatefulWidget {
  List<OptionPickerModel> items;
  List<String> selected_items;
  String title;
  bool single_select;

  SingleOptionPicker(
      this.title, this.items, this.selected_items, this.single_select);

  @override
  State<SingleOptionPicker> createState() => SingleOptionPickerState();
}

late CustomTheme customTheme;

class SingleOptionPickerState extends State<SingleOptionPicker> {
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
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: MyColors.primary,
          elevation: 10,
          onPressed: () {
            done_selecting();
            //Utils.navigate_to(AppConfig.TasksCreateScreen, context);
          },
          label: Row(
            children: [
              Icon(
                Icons.check,
                size: 18,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: FxText(
                  "DONE SELECTING",
                  fontWeight: 800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: CustomTheme.primary,
          elevation: .5,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: search_form_is_open
              ? Container(
                  padding: EdgeInsets.only(left: 15),
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  margin: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  child: TextFormField(
                    decoration: customTheme.input_decoration_4(
                        labelText: "Search...", icon: Icons.search),
                    controller: search_controler,
                    focusNode: seachrFocusNode,
                    textInputAction: TextInputAction.search,
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (s) {
                      _do_refresh();
                    },
                    onChanged: (s) {
                      _do_refresh();
                    },
                  ),
                )
              : Text(
                  widget.title,
                ),
          actions: [
            InkWell(
                onTap: () {
                  setState(() {
                    seachrFocusNode.requestFocus();
                    search_form_is_open = !search_form_is_open;
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      search_form_is_open ? Icons.clear : Icons.search,
                      size: 25,
                      color: Colors.white,
                    )))
          ],
        ),
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: _do_refresh,
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          child: CustomScrollView(
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
          ),
        )),
      );
    });
  }

  List<OptionPickerModel> ready_items = [];
  String search_keyword = "";

  Future<Null> _do_refresh() async {
    search_keyword = "";
    is_loading = true;
    setState(() {});
    if (search_controler != null) {
      if (search_controler.text != null) {
        if (!search_controler.text.toString().isEmpty) {
          search_keyword = search_controler.text.toString();
        }
      }
    }

    ready_items.clear();
    if (search_keyword.length > 1) {
      widget.items.forEach((element) {
        if (element.name.toLowerCase().contains(search_keyword.toLowerCase())) {
          if (widget.selected_items.contains(element.id.toString())) {
            element.selected = true;
          } else {
            element.selected = false;
          }
          ready_items.add(element);
        }
      });
    } else {
      widget.items.forEach((element) {
        if (widget.selected_items.contains(element.id.toString())) {
          element.selected = true;
        } else {
          element.selected = false;
        }
        ready_items.add(element);
      });
    }

    is_loading = false;
    setState(() {});

    return await _onRefresh(context);
  }

  SingleProduct(OptionPickerModel item) {
    return ListTile(
      dense: true,
      title: FxText(item.name, fontWeight: 600, fontSize: 18),
      onTap: () {
        pick_location(item);
      },
      trailing: item.selected
          ? Icon(
              Icons.check,
              size: 25,
              color: CustomTheme.primary,
            )
          : SizedBox(),
    );
  }

  Future<void> pick_location(OptionPickerModel item) async {
    if (widget.selected_items.contains(item.id.toString())) {
      widget.selected_items.remove(item.id.toString());
    } else {
      widget.selected_items.add(item.id.toString());
    }

    if (widget.single_select) {
      done_selecting();
    }
    _do_refresh();
  }

  void done_selecting() {
    Navigator.pop(context, {"selected": widget.selected_items});
  }
}
