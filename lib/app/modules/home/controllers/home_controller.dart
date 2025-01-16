import 'package:easy_scanner/app/core/constants/app_string_constants.dart';
import 'package:easy_scanner/app/core/services/storage_service.dart';
import 'package:easy_scanner/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;

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

  Future<void> pickAndScanImage() async {
    try {
      final ImagePicker _picker = ImagePicker();

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        return;
      }

      Get.back();

      final MobileScannerController mobileScannerController =
          MobileScannerController();

      try {
        mobileScannerController.analyzeImage(pickedFile.path).then(
          (capture) {
            if (capture?.barcodes.isNotEmpty ?? false) {
              Barcode? barcode = capture?.barcodes.firstOrNull;
              Get.toNamed(Routes.SCANNER_DETAILS, arguments: barcode);
              return;
            }
          },
        );
      } catch (e) {
        return;
      }
    } catch (e) {
      return;
    }
  }
}
