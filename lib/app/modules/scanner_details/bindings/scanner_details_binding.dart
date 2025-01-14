import 'package:get/get.dart';

import '../controllers/scanner_details_controller.dart';

class ScannerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerDetailsController>(
      () => ScannerDetailsController(),
    );
  }
}
