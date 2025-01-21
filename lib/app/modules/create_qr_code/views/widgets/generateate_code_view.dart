import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneratedCodeView extends StatelessWidget {
  final BarcodeWidget barcodeWidget;
  final bool? isBar;
  final Function onDownload;
  const GeneratedCodeView(
      {super.key,
      required this.barcodeWidget,
      this.isBar = false,
      required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isBar == false ? 200 : 100,
        width: isBar == false ? 200 : Get.width,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: CustomWidgetElements.commonDecorationWithShadow(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            barcodeWidget,
            InkWell(
              onTap: () {
                onDownload();
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
            )
          ],
        ),
      ),
    );
  }
}
