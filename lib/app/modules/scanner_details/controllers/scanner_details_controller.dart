import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:mobile_scanner/mobile_scanner.dart' as m_s;

class ScannerDetailsController extends GetxController {
  m_s.Barcode? barcode;
  RxString type = ''.obs;

  Map<b_w.BarcodeType, m_s.BarcodeFormat> barcodeMapping = {
    b_w.BarcodeType.Code128: m_s.BarcodeFormat.code128,
    b_w.BarcodeType.Code39: m_s.BarcodeFormat.code39,
    b_w.BarcodeType.Code93: m_s.BarcodeFormat.code93,
    b_w.BarcodeType.Codabar: m_s.BarcodeFormat.codabar,
    b_w.BarcodeType.DataMatrix: m_s.BarcodeFormat.dataMatrix,
    b_w.BarcodeType.CodeEAN13: m_s.BarcodeFormat.ean13,
    b_w.BarcodeType.CodeEAN8: m_s.BarcodeFormat.ean8,
    b_w.BarcodeType.Itf: m_s.BarcodeFormat.itf,
    b_w.BarcodeType.QrCode: m_s.BarcodeFormat.qrCode,
    b_w.BarcodeType.CodeUPCA: m_s.BarcodeFormat.upcA,
    b_w.BarcodeType.CodeUPCE: m_s.BarcodeFormat.upcE,
    b_w.BarcodeType.PDF417: m_s.BarcodeFormat.pdf417,
    b_w.BarcodeType.Aztec: m_s.BarcodeFormat.aztec,
  };

  b_w.BarcodeType? getBarcodeType(m_s.BarcodeFormat format) {
    return barcodeMapping.entries
        .firstWhere((entry) => entry.value == format)
        .key;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      try {
        barcode = Get.arguments;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
