import '../../../Constants/stts_uganda_exports.dart';

class TrackScreen extends StatefulWidget {
  final String? lotNumber;
  const TrackScreen({super.key, this.lotNumber});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  SeedScanningController seedScanningController = SeedScanningController();

  @override
  void initState() {
    seedScanningController.fetchTracks(widget.lotNumber.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: seedScanningController,
      child: Consumer<SeedScanningController>(
        builder: (_, model, child) {
          if (model.traces.isEmpty && !model.isLoading) {
            return const Center(
              child: Text(
                'No track found',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (model.isLoading) {
            return const SttsLoader();
          }

          return ListView.builder(
              itemCount: model.traces.length,
              itemBuilder: (BuildContext context, index) {
                return ScanningWigdet(
                  trace: model.traces[index],
                );
              });
        },
      ),
    );
  }
}
