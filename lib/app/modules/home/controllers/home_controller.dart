import 'package:easy_scanner/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  void changeTab(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  onBusinessCardScan() async {
    Get.toNamed(Routes.BUSINESS_CARD_DETAILS);
  }
}
