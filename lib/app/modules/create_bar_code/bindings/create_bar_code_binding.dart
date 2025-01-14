import 'package:get/get.dart';

import '../controllers/create_bar_code_controller.dart';

class CreateBarCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBarCodeController>(
      () => CreateBarCodeController(),
    );
  }
}
