import '../../../Constants/stts_uganda_exports.dart';
import 'package:intl/intl.dart';

class SeedLabelList extends StatefulWidget {
  final String title = "My Seed Labels";

  const SeedLabelList({Key? key}) : super(key: key);

  @override
  State<SeedLabelList> createState() => SeedLabelListState();
}

late CustomTheme customTheme;

class SeedLabelListState extends State<SeedLabelList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;
  SeedController seedController = SeedController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    seedController.fetchSeedLabels(locator<UserController>().user?.id);
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
                InkWell(
                    onTap: () {
                      setState(() {
                        Utils.navigate_to(AppConfig.seedLabelForm, context);
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.white,
                        )))
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
                        child: model.seedLabels.isEmpty
                            ? MyWidgets.my_empty_widget(context,
                                'You have not applied for any seed label. Press the "+" button in top right conner to apply for one.')
                            : CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return SingleProduct(
                                            model.seedLabels[index]);
                                      },
                                      childCount: model
                                          .seedLabels.length, // 1000 list items
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
    is_loading = true;

    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(SeedLabel item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            // Utils.navigate_to(AppConfig.detailsScreen, context,
            //     data: item.get_details());
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date created:  ${DateFormat('EEEE, d MMM, yyyy').format(
                    DateTime.parse(item.createdAt.toString()),
                  )}",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (item.availableStock != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: FxText(
                      "Available stock - ${item.availableStock}",
                      fontSize: 16,
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
    String raw = await Utils.http_post('seed-labels/delete', {'id': id});
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
