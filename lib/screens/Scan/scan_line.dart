import 'package:STTS/Constants/colors.dart';

import '../../Constants/stts_uganda_exports.dart';

class ScanLine extends StatefulWidget {
  const ScanLine({super.key});

  @override
  State<ScanLine> createState() => _ScanLineState();
}

class _ScanLineState extends State<ScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: twoSeconds,
      reverseDuration: twoSeconds,
    );

    _animation = Tween<double>(begin: 0, end: 1.0).animate(_controller);

    _controller.forward();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const color = sttsWhite;
    const double lineHeight = 10;

    return LayoutBuilder(builder: (context, contraints) {
      final height = contraints.maxHeight;

      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -height * .02),
          end: Offset(0, height * .08),
        ).animate(_animation),
        child: Container(
          height: lineHeight,
          width: height,
          decoration: BoxDecoration(
            color: color,
            border: const Border(
              bottom: BorderSide(color: color, width: 3),
            ),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(.6),
                color,
              ],
            ),
          ),
        ),
      );
    });
  }
}
