import 'package:easy_scanner/app/core/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as m_s;

class ScannerDetailsController extends GetxController {
  Rx<m_s.Barcode?> barcode = Rx(null);

  @override
  void onInit() {
    if (Get.arguments != null) {
      try {
        barcode.value = Get.arguments;

        if (barcode.value != null) {
          StorageService().addNewBarcodeData(
            barcode: barcode.value!,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        barcode.value = null;
      }
    }
    super.onInit();
  }
}
