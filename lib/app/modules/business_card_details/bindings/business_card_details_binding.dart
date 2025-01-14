import 'package:easy_scanner/app/modules/business_card_details/controllers/business_card_details_controller.dart';
import 'package:get/get.dart';

class BusinessCardDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BusinessCardDetailsController());
  }
}
