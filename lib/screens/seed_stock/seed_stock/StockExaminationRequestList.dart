import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/FormStockExaminationRequestModel.dart';
import 'package:STTS/models/stock_examination.dart';
import 'package:STTS/screens/seed_stock/seed_stock/stock_examination_form.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class StockExaminationRequestList extends StatefulWidget {
  String title = "My stock examination";

  StockExaminationRequestList({Key? key}) : super(key: key);

  @override
  State<StockExaminationRequestList> createState() =>
      StockExaminationRequestListState();
}

late CustomTheme customTheme;

class StockExaminationRequestListState
    extends State<StockExaminationRequestList> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  SeedController seedController = SeedController();

  List<FormStockExaminationRequestModel> items = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    seedController.fetchStockExaminations(locator<UserController>().user?.id);
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
                style: const TextStyle(color: MyColors.grey_3),
              ),
              actions: [
                if (locator<UserController>().user?.roles[0].name ==
                    "Basic User")
                  InkWell(
                    onTap: () {
                      setState(() {
                        Utils.navigate_to(
                            AppConfig.stockExaminationRequestForm, context);
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
                        onRefresh: doRefresh,
                        color: CustomTheme.primary,
                        backgroundColor: Colors.white,
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return SingleProduct(
                                      model.stockExaminations[index]);
                                },
                                childCount: model.stockExaminations
                                    .length, // 1000 list items
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

  Future<void> doRefresh() async {
    seedController.fetchStockExaminations(locator<UserController>().user?.id);
    return await _onRefresh(context);
  }

  // ignore: non_constant_identifier_names
  SingleProduct(StockExamination item) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (locator<UserController>().user?.roles[0].name == "Inspector") {
              Get.to(
                StockExaminationForm(
                  id: item.stockExamForm?.id,
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
                if (item.stockExamForm?.date != null)
                  Row(
                    children: [
                      const Text("Date:  "),
                      FxText(
                        "${item.stockExamForm?.date}",
                        fontSize: 20,
                        height: 1.1,
                        color: Colors.grey.shade900,
                      ),
                    ],
                  ),
                if (item.stockExamForm?.date != null)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    const Text("Status:"),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6, top: 0),
                      child: Utils.tell_status_widget(
                          item.stockExamForm!.status.toString()),
                    ),
                  ],
                ),
                if (item.stockExamForm!.yield != null)
                  Row(
                    children: [
                      const Text("Yield:  "),
                      Text(item.stockExamForm!.yield.toString()),
                    ],
                  ),
                if (item.stockExamForm!.lotNumber != null)
                  Row(
                    children: [
                      const Text("Lot number:  "),
                      Text(item.stockExamForm!.lotNumber.toString()),
                    ],
                  ),
                if (item.stockExamForm?.createdAt != null)
                  Row(
                    children: [
                      const Text("Created date:  "),
                      Text(
                        DateFormat('EEEE, d MMM, yyyy').format(
                          DateTime.parse(
                              item.stockExamForm!.createdAt.toString()),
                        ),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
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
    String raw = await Utils.http_post(
        'form-stock-examination-requests/delete', {'id': id});
    RespondModel resp = RespondModel(raw);

    is_loading = false;
    setState(() {});

    if (resp.code == 1) {
      Utils.showSnackBar(resp.message, context,
          color: Colors.white, background_color: Colors.green.shade600);
      doRefresh();
    } else {
      Utils.showSnackBar(resp.message, context,
          color: Colors.white, background_color: Colors.red.shade600);
    }
  }
}
