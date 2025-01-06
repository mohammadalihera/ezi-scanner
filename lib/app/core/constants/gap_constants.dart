import 'package:flutter/material.dart';

// Horizontal gaps
const horizontal4 = SizedBox(width: 4);
const horizontal8 = SizedBox(width: 8);
const horizontal12 = SizedBox(width: 12);
const horizontal16 = SizedBox(width: 16);
const horizontal20 = SizedBox(width: 20);
const horizontal24 = SizedBox(width: 24);
const horizontal28 = SizedBox(width: 28);
const horizontal32 = SizedBox(width: 32);
const horizontal36 = SizedBox(width: 36);
const horizontal40 = SizedBox(width: 40);

// Vertical gaps
const vertical4 = SizedBox(height: 4);
const vertical8 = SizedBox(height: 8);
const vertical12 = SizedBox(height: 12);
const vertical16 = SizedBox(height: 16);
const vertical20 = SizedBox(height: 20);
const vertical24 = SizedBox(height: 24);
const vertical28 = SizedBox(height: 28);
const vertical32 = SizedBox(height: 32);
const vertical36 = SizedBox(height: 36);
const vertical40 = SizedBox(height: 40);

vertical(double height) {
  return SizedBox(height: height);
}

horizontal(double width) {
  return SizedBox(width: width);
}

BorderRadius radius2 = BorderRadius.circular(2);
BorderRadius radius4 = BorderRadius.circular(4);
BorderRadius radius6 = BorderRadius.circular(6);
BorderRadius radius8 = BorderRadius.circular(8);
BorderRadius radius10 = BorderRadius.circular(10);
BorderRadius radius12 = BorderRadius.circular(12);
BorderRadius radius14 = BorderRadius.circular(14);
BorderRadius radius16 = BorderRadius.circular(16);
BorderRadius radius18 = BorderRadius.circular(18);
BorderRadius radius20 = BorderRadius.circular(20);
BorderRadius radius22 = BorderRadius.circular(22);
BorderRadius radius24 = BorderRadius.circular(24);
BorderRadius radius26 = BorderRadius.circular(26);
BorderRadius radius28 = BorderRadius.circular(28);
BorderRadius radius30 = BorderRadius.circular(30);
BorderRadius radius32 = BorderRadius.circular(32);

radius(double radius) {
  return BorderRadius.circular(radius);
}

radiusOnly({
  double? topLeft,
  double? topRight,
  double? bottomLeft,
  double? bottomRight,
  double? bottom,
  double? top,
}) {
  return BorderRadius.only(
    topLeft: Radius.circular(top ?? topLeft ?? 0),
    topRight: Radius.circular(top ?? topRight ?? 0),
    bottomLeft: Radius.circular(bottom ?? bottomLeft ?? 0),
    bottomRight: Radius.circular(bottom ?? bottomRight ?? 0),
  );
}

const double size2 = 2.0;
const double size4 = 4.0;
const double size6 = 6.0;
const double size8 = 8.0;
const double size10 = 10.0;
const double size12 = 12.0;
const double size14 = 14.0;
const double size16 = 16.0;
const double size18 = 18.0;
const double size20 = 20.0;
const double size22 = 22.0;
const double size24 = 24.0;
const double size26 = 26.0;
const double size28 = 28.0;
const double size30 = 30.0;
const double size32 = 32.0;
