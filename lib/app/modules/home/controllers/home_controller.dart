import 'package:easy_scanner/app/modules/dashboard/views/dashboard_view.dart';
import 'package:easy_scanner/app/modules/history/views/history_view.dart';
import 'package:easy_scanner/app/modules/settings/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  void changeTab(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  final List<Widget> screens = [DashboardView(), HistoryView(), SettingsView()];
}
