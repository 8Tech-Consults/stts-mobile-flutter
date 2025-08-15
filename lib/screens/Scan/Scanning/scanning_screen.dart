import '../../../Constants/stts_uganda_exports.dart';

class ScanningScreen extends StatefulWidget {
  final String? lotNumber;
  const ScanningScreen({super.key, this.lotNumber});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  SeedScanningController seedScanningController = SeedScanningController();
  @override
  void initState() {
    seedScanningController.traceSeed(widget.lotNumber.toString());
    super.initState();
  }

  final List<String> scanTitles = [
    "Trace",
    "Track",
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: seedScanningController,
      child: Consumer<SeedScanningController>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Scanned Seed',
                style: TextStyle(color: sttsColor),
              ),
            ),
            body: model.isLoading
                ? const SttsLoader()
                : DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          constraints: const BoxConstraints(maxHeight: 150.0),
                          child: Material(
                            child: TabBar(
                              tabs: [
                                Tab(
                                  text: scanTitles[1],
                                ),
                                Tab(
                                  text: scanTitles[0],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              TrackScreen(
                                lotNumber: model.trace?.lotNumber,
                              ),
                              TraceScreen(
                                trace: model.trace,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
