import '../../Constants/stts_uganda_exports.dart';

class FlashIcon extends StatefulWidget {
  final MobileScannerController qrScannerController;

  const FlashIcon({super.key, required this.qrScannerController});

  @override
  State<FlashIcon> createState() => _FlashIconState();
}

class _FlashIconState extends State<FlashIcon> {
  bool isTorchOn = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: quarterSeconds,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: sttsWhite),
          color: isTorchOn ? sttsWhite : sttsTransparent,
        ),
        padding: const EdgeInsets.all(5),
        child: IconButton(
          onPressed: () {
            widget.qrScannerController.toggleTorch();
            setState(() {
              isTorchOn = !isTorchOn;
            });
          },
          icon: Icon(
            isTorchOn ? Icons.flash_off : Icons.flash_on,
            color: isTorchOn ? sttsBlack : sttsWhite,
          ),
        ),
      ),
    );
  }
}