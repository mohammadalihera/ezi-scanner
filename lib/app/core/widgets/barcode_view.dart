import 'dart:io';
import 'dart:typed_data';

import 'package:easy_scanner/app/core/services/image_picker_service.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class BarcodeView extends StatefulWidget {
  final b_w.BarcodeWidget barcode;
  const BarcodeView({super.key, required this.barcode});

  @override
  State<BarcodeView> createState() => _BarcodeViewState();
}

class _BarcodeViewState extends State<BarcodeView> {
  final ScreenshotController screenshotController = ScreenshotController();

  void _downloadBarcode() async {
    try {
      int dateTime = DateTime.now().millisecondsSinceEpoch;
      Uint8List? imageBytes = await screenshotController.capture();
      if (imageBytes == null) return;

      final directory = await getTemporaryDirectory();
      final filePath = "${directory.path}/${dateTime}.png";
      File file = File(filePath);
      await file.writeAsBytes(imageBytes);

      await ImagePickerService.saveImage(
          imageFile: file, fileName: '${dateTime.toString()}.png');
    } catch (e) {
      Get.snackbar('Failed', 'Download failed. Please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: CustomWidgetElements.commonDecorationWithShadow(),
        child: Stack(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                decoration:
                    CustomWidgetElements.commonDecoration(color: Colors.white),
                padding: EdgeInsets.all(10),
                child: widget.barcode,
              ),
            ),
            Positioned(
              left: 65,
              top: 65,
              child: InkWell(
                onTap: () {
                  _downloadBarcode();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: CustomWidgetElements.commonDecoration(
                    radius: BorderRadius.circular(25),
                    color: Colors.green[600]!.withOpacity(0.8),
                  ),
                  child: const Icon(
                    Icons.download_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
