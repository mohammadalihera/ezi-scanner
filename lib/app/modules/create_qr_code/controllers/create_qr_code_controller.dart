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
  RxBool otherTypes = false.obs;
  RxString urlPrefix = 'http://'.obs;
  RxString selectedEncryptionType = 'WEP'.obs;
  RxString selectedCreateType = 'Barcode'.obs;

  RxString selectedOption = "url".obs;
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  Map<String, TextEditingController> textControllers = {
    "url": TextEditingController(),
    "text": TextEditingController(),
    "name": TextEditingController(),
    "email": TextEditingController(),
    "sub": TextEditingController(),
    "body": TextEditingController(),
    "phone": TextEditingController(),
    "sms": TextEditingController(),
    "message": TextEditingController(),
    "latitude": TextEditingController(),
    "longitude": TextEditingController(),
    "title": TextEditingController(),
    "description": TextEditingController(),
    "location": TextEditingController(),
    "start": TextEditingController(),
    "end": TextEditingController(),
    "ssid": TextEditingController(),
    "password": TextEditingController(),
    "encryption": TextEditingController(),
    "custom": TextEditingController(),
  };

  @override
  void onInit() {
    specs = GenerateService().getBarcodeSpecs(selectedType.value).obs;
    super.onInit();
  }

  @override
  void onClose() {
    barcodeController.dispose();
    focusNode.dispose();
    textControllers.forEach((key, value) => value.dispose());
    super.onClose();
  }

  saveCode() async {
    focusNode.unfocus();
    String filePath = "";
    if (selectedType.value == BarcodeType.QrCode) {
      var savedQrFilePath = await GenerateService().saveQrCode(barcodeData.value);
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
    // focusNode.unfocus();
  }

  void generateOtherTypeQRCode() {
    // focusNode.unfocus();
    if (!formKey.currentState!.validate()) return;

    String qrData = "";
    switch (selectedOption.value) {
      case "url":
        qrData = textControllers["url"]!.text;
        break;
      case "text":
        qrData = textControllers["text"]!.text;
        break;
      case "contact":
        qrData =
            "MECARD:N:${textControllers["name"]!.text};TEL:${textControllers["phone"]!.text};EMAIL:${textControllers["email"]!.text};;";
        break;
      case "email":
        qrData =
            "MATMSG:TO:${textControllers["email"]!.text};SUB:${textControllers["sub"]!.text};BODY:${textControllers["body"]!.text};;";
        break;
      case "sms":
        qrData = "SMSTO:${textControllers["phone"]!.text}:${textControllers["message"]!.text}";
        break;
      case "geo":
        qrData = "geo:${textControllers["latitude"]!.text},${textControllers["longitude"]!.text}";
        break;
      case "phone":
        qrData = textControllers["phone"]!.text;
        break;
      case "calender":
        qrData =
            "BEGIN:VEVENT\nSUMMARY:${textControllers["title"]!.text}\nDTSTART:${textControllers["start"]!.text}\nDTEND:${textControllers["end"]!.text}\nLOCATION:${textControllers["location"]!.text}\nDESCRIPTION:${textControllers["description"]!.text}\nEND:VEVENT";
        break;
      case "wifi":
        qrData =
            "WIFI:T:${selectedEncryptionType.value};S:${textControllers["ssid"]!.text};P:${textControllers["password"]!.text};;";
        break;
      case "My Qr":
        qrData = textControllers["custom"]!.text;
        break;
    }

    // generatedQRCode.value = qrData;
    barcodeData.value = qrData;
    // focusNode.unfocus();
  }

  void toggleOtherTypes() {
    otherTypes.value = !otherTypes.value;
    if (otherTypes.value) {
      selectedType.value = BarcodeType.QrCode;
    }
    barcodeData.value = "";
  }
}
