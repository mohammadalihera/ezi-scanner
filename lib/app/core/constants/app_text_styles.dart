import 'package:easy_scanner/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _fontFamily = 'Nunito';

  // Regular - 400
  static final TextStyle _regular = TextStyle(
    color: AppColors.textPrimaryColor,
    height: 1.5,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
  );

  // headlines
  static TextStyle h1 = _regular.copyWith(
    fontSize: 28,
    height: 40 / 28,
  );

  static TextStyle h1Bold = h1.copyWith(
    fontWeight: FontWeight.w700,
  );

  static TextStyle h1ExtraBold = h1.copyWith(
    fontWeight: FontWeight.w800,
  );

  static TextStyle h2 = _regular.copyWith(
    fontSize: 24,
    height: 36 / 24,
  );

  static TextStyle h2Bold = h2.copyWith(
    fontWeight: FontWeight.w700,
  );

  static TextStyle h2ExtraBold = h2.copyWith(
    fontWeight: FontWeight.w800,
  );

  static TextStyle h3 = _regular.copyWith(
    fontSize: 20,
    height: 32 / 20,
  );

  static TextStyle h3Bold = h3.copyWith(
    fontWeight: FontWeight.w700,
  );

  static TextStyle h3ExtraBold = h3.copyWith(
    fontWeight: FontWeight.w800,
  );

  static TextStyle h4 = _regular.copyWith(
    fontSize: 18,
    height: 28 / 18,
  );

  static TextStyle h4Bold = h4.copyWith(
    fontWeight: FontWeight.w700,
  );

  static TextStyle h5 = _regular.copyWith(
    fontSize: 16,
    height: 24 / 16,
  );

  static TextStyle h5Bold = h5.copyWith(
    fontWeight: FontWeight.w700,
  );

  // body
  static TextStyle bodySmall = _regular.copyWith(
    fontSize: 14,
    height: 20 / 14,
  );

  static TextStyle bodySmallSemiBold = bodySmall.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyXSmall = _regular.copyWith(
    fontSize: 12,
    height: 18 / 12,
  );

  static TextStyle bodyXSmallMedium = bodyXSmall.copyWith(
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyXSmallBold = bodyXSmall.copyWith(
    fontWeight: FontWeight.w700,
  );

  // button
  static TextStyle button = _regular.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static TextStyle buttonBold16 = button.copyWith(
    height: 24 / 16,
  );

  static TextStyle buttonBold18 = button.copyWith(
    fontSize: 18,
    height: 28 / 18,
  );

  static TextStyle buttonBold20 = button.copyWith(
    fontSize: 20,
    height: 32 / 20,
  );
}
