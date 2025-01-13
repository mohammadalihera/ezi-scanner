import 'package:easy_scanner/app/core/constants/app_colors.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  const LabelValueWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) icon!,
          horizontal4,
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
