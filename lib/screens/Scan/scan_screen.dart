import 'package:STTS/Constants/font_sizes.dart';
import 'package:STTS/Constants/padding.dart';
import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/screens/Scan/qr_simulator.dart';
import 'package:STTS/screens/Scan/to_scan_button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding16,
        child: ExpandedScrollingColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, ${locator<UserController>().user?.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MyColors.grey_100_,
                fontWeight: FontWeight.bold,
                fontSize: fontSize16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const AnimatedSwitcher(
              duration: Duration(seconds: 5),
              child: Text(
                'Track a Seed',
                key: ValueKey('Track'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.grey_100_,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize32,
                ),
              ),
            ),
            const Text(
              'You can track & trace a seed by scanning the QR Code on the Seed pack(bag) label.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.grey_100_,
                fontSize: fontSize16,
              ),
            ),
            const QrCodeSimulator(),
            Text(
              'Scan the Seed QR Code to track it.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.grey_100_.withOpacity(.5),
                fontSize: fontSize12,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ToScanButton(),
          ],
        ),
      ),
    );
  }
}
