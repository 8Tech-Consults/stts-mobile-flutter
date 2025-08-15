import 'package:STTS/widgets/button/button_body.dart';

import '../../Constants/stts_uganda_exports.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.textColor = MyColors.grey_10,
    this.buttonColor = MyColors.primary,
    this.icon,
    this.iconWidget,
    this.toolTip,
    this.isSmallButton = false,
  });

  static Widget small({
    required String label,
    required VoidCallback onTap,
    Color textColor = MyColors.grey_100_,
    Color buttonColor = MyColors.primary,
    IconData? icon,
    Widget? iconWidget,
    String? toolTip,
  }) =>
      AppButton(
        label: label,
        onTap: onTap,
        textColor: textColor,
        buttonColor: buttonColor,
        icon: icon,
        iconWidget: iconWidget,
        toolTip: toolTip,
        isSmallButton: true,
      );

  ///Wether the button is small or not
  final bool isSmallButton;

  // text label
  final String label;
  final Widget? iconWidget;
  final VoidCallback? onTap;
  final Color textColor, buttonColor;
  final IconData? icon;
  final String? toolTip;

  @override
  Widget build(BuildContext context) {
    return ButtonBody(
      buttonColor: buttonColor,
      toolTip: toolTip,
      text: label,
      textColor: textColor,
      iconData: icon,
      iconWidget: iconWidget,
      onTap: onTap,
      isSmallButton: isSmallButton,
    );
  }
}
