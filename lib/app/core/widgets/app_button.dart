import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String name;
  final Function onTap;
  final Widget? icon;
  final Color? textColor;
  final Color? buttonColor;
  final double? width;
  final double? height;
  const AppButton({
    super.key,
    required this.name,
    required this.onTap,
    this.icon,
    this.buttonColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width,
      child: ElevatedButton.icon(
        onPressed: () => onTap(),
        icon: icon,
        label: Text(name, textAlign: TextAlign.end),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: buttonColor ?? Colors.white,
          textStyle: AppTextStyles.button.copyWith(
            color: textColor ?? Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          iconColor: textColor ?? Colors.black,
          foregroundColor: textColor ?? Colors.black,
        ),
      ),
    );
  }
}
