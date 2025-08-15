import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../Constants/stts_uganda_exports.dart';

class QrScanArea extends StatefulWidget {
  final MobileScannerController qrScannerController;
  const QrScanArea({super.key, required this.qrScannerController});

  @override
  State<QrScanArea> createState() => _QrScanAreaState();
}

class _QrScanAreaState extends State<QrScanArea> {
  dynamic scanned;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: widget.qrScannerController,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                final image = capture.image; // This may be null if no image is provided

                for (final barcode in barcodes) {
                  setState(() {
                    scanned = barcode.rawValue;
                  });
                }

                // image is now a Uint8List? so width/height are not available
                // If you need the dimensions, you'll have to process image metadata yourself
                // final aspectRatio = (imageWidth / imageHeight);

                await Future.delayed(oneSecond).then(
                  (_) => Get.to(
                    ScanningScreen(
                      lotNumber: scanned,
                    ),
                  ),
                );
              },
            ),
          ),

          // ✅ Custom overlay
          Positioned.fill(
            child: QrScanFrame(
              mobileScannerController: widget.qrScannerController,
            ),
          ),
        ],
      ),
    );
  }
}
