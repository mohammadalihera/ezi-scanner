import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomWidgetElements {
  static commonAppBar({required String title, bool back = false}) {
    return AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[50],
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: back
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  static commonDecorationWithShadow({
    BorderRadius? radius,
    Color color = Colors.white,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: radius ?? radius10,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(2, 2),
        ),
      ],
    );
  }

  static commonDecoration({
    BorderRadius? radius,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: radius ?? radius10,
    );
  }
}
