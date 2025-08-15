import 'package:flutter/material.dart';

class SttsLoader extends StatelessWidget {
  const SttsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
