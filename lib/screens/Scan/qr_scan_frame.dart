import 'package:STTS/Constants/margins.dart';
import '../../Constants/stts_uganda_exports.dart';

class QrScanFrame extends StatelessWidget {
  const QrScanFrame({
    super.key,
    this.width,
    this.height,
    required this.mobileScannerController,
  });
  // mobileScannerController
  final MobileScannerController mobileScannerController;

  // width and height nullable doubles
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sttsBlack.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // scan frame
          Center(
            child: ClipPath(
              clipper: QRCodeFrameClipper(),
              child: Container(
                margin: margin8,
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: sttsWhite, width: 2.0),
                  borderRadius: borderRadius8,
                ),
              ),
            ),
          ),
          //
          const VerticalSpace(of: spacing16),
          FlashIcon(qrScannerController: mobileScannerController),
        ],
      ),
    );
  }
}

class QRCodeFrameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double frameWidth = size.width * 0.6; // Adjust the frame width here
    final double frameHeight =
        size.height * 0.4; // Adjust the frame height here

    final double frameX = (size.width - frameWidth) / 2;
    final double frameY = (size.height - frameHeight) / 2;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(frameX, frameY, frameWidth, frameHeight),
          const Radius.circular(8.0),
        ),
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
