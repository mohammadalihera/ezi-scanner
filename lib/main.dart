import 'package:easy_scanner/app/core/services/storage_service.dart';
import 'package:easy_scanner/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await StorageService.init();

  await Future.delayed(Duration(seconds: 1));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightTheme,
    ),
  );
}
