import 'package:get/get.dart';

import '../controllers/create_qr_code_controller.dart';

class CreateQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateQrCodeController>(
      () => CreateQrCodeController(),
    );
  }
}
