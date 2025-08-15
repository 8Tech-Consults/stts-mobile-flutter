import 'package:get/get.dart';

import '../../Constants/stts_uganda_exports.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final mobileScannerController = MobileScannerController(returnImage: true);

  @override
  void dispose() {
    // dispose controller
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: sttsBlack,
      appBar: AppBar(
        title: const Text('Scan Code', style: TextStyle(color: sttsWhite)),
        leading: BackButton(
          color: sttsWhite,
          onPressed: () {
            mobileScannerController.dispose();
            Get.back();
          },
        ),
        backgroundColor: sttsTransparent,
      ),
      body: QrScanArea(qrScannerController: mobileScannerController),
      bottomNavigationBar: Container(),
    );
  }
}
