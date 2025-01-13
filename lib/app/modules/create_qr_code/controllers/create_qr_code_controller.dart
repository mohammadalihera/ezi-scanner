import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_scanner/app/core/services/generate_qr_barcode_service.dart';
import 'package:easy_scanner/app/data/models/barcode_spec.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateQrCodeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final barcodeController = TextEditingController();
  Rx<BarcodeType> selectedType = (BarcodeType.QrCode).obs;
  Rx<String> barcodeData = ("").obs;
  final focusNode = FocusNode();

  late Rx<BarcodeSpec> specs;

  @override
  void onInit() {
    specs = GenerateService().getBarcodeSpecs(selectedType.value).obs;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    barcodeController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  saveCode() async {
    focusNode.unfocus();
    String filePath = "";
    if (selectedType.value == BarcodeType.QrCode) {
      var savedQrFilePath =
          await GenerateService().saveQrCode(barcodeData.value);
      filePath = savedQrFilePath;
      if (kDebugMode) {
        print("savedQrFilePath: $savedQrFilePath");
      }
    } else {
      var savedBarcodeFilePath = await GenerateService().saveBarcode(
        type: selectedType.value,
        content: barcodeData.value,
      );
      filePath = savedBarcodeFilePath;
      if (kDebugMode) {
        print("savedBarcodeFilePath: $savedBarcodeFilePath");
      }
    }

    if (filePath != "") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(
            'Successfully crated and saved the ${selectedType.value.name}',
          ),
        ),
      );
    }
  }

  void generateCode() {
    if (formKey.currentState?.validate() ?? false) {
      barcodeData.value = barcodeController.text;
    }
    focusNode.unfocus();
  }
}
