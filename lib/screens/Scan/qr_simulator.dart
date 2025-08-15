import 'package:STTS/Constants/icon_path.dart';
import 'package:STTS/Constants/padding.dart';
import 'package:STTS/screens/Scan/scan_line.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constants/stts_uganda_exports.dart';

class QrCodeSimulator extends StatelessWidget {
  const QrCodeSimulator({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final iconSize = height * .35;
    return Padding(
      padding: verticalPadding16,
      child: SizedBox(
        height: iconSize,
        width: iconSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              qrCode,
              semanticsLabel: 'Qr Code Simulator',
              width: iconSize,
              height: iconSize,
            ),
            const ScanLine(),
          ],
        ),
      ),
    );
  }
}
