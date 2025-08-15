import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/screens/Scan/qr_scanner.dart';
import 'package:STTS/widgets/button/app_button.dart';
import 'package:get/get.dart';

class ToScanButton extends StatelessWidget {
  const ToScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: "Scan QR Code",
      icon: Icons.qr_code_scanner,
      onTap: () => {
        Get.to(
          const QrScannerScreen(),
        ),
      },
    );
  }
}
