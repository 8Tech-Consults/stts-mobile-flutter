import 'package:STTS/Constants/stts_uganda_exports.dart';

class VerticalSpace extends StatelessWidget {
  ///Adds space vertically
  const VerticalSpace({super.key, required this.of});

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: of);
  }
}

class EmptySpace extends StatelessWidget {
  ///Adds Empty space
  const EmptySpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
