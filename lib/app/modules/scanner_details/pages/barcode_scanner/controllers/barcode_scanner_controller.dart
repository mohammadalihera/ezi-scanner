import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerController extends GetxController {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool isScanning = true;
  final double scanAreaSize = 250;

  // qrcode, barcode
  String scannerType = "";

  @override
  void onInit() {
    if (Get.arguments != null) {
      scannerType = Get.arguments;
    }
    super.onInit();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  void handleDetect(BarcodeCapture capture) {
    if (isScanning) {
      isScanning = false;
      Barcode? barcode = capture.barcodes.firstOrNull;
      if (barcode != null) {
        if (barcode.format == BarcodeFormat.qrCode && scannerType == "qrcode") {
          _showBarcodeDialog(
            barcode.rawValue ?? 'Failed to read',
            barcode.type.name,
            barcode.format.name,
          ).then(
            (value) {
              if (!isScanning) {
                Get.back(result: barcode);
              }
            },
          );
        } else if (barcode.format != BarcodeFormat.qrCode &&
            scannerType == "barcode") {
          _showBarcodeDialog(
            barcode.rawValue ?? 'Failed to read',
            barcode.type.name,
            barcode.format.name,
          ).then(
            (value) {
              if (!isScanning) {
                Get.back(result: barcode);
              }
            },
          );
        }
      }
    }
  }

  Future _showBarcodeDialog(
      String barcodeValue, String type, String format) async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scan Result'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Value: $barcodeValue'),
                const SizedBox(height: 8),
                Text('Type: $type'),
                const SizedBox(height: 8),
                Text('Format: $format'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Scan Again'),
              onPressed: () {
                isScanning = true;
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                isScanning = false;
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
