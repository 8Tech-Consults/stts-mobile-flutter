import 'package:STTS/models/trace.dart';
import 'package:STTS/screens/Scan/Scanning/scanning_widget.dart';
import 'package:flutter/material.dart';

class TraceScreen extends StatelessWidget {
  final Trace? trace;
  const TraceScreen({super.key, this.trace});

  @override
  Widget build(BuildContext context) {
    return trace == null
        ? const Center(
            child: Text(
              'No trace found',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )
        : ScanningWigdet(
            trace: trace,
          );
  }
}
