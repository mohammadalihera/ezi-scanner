import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/modules/home/views/widgets/custome_card.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/image_scanner_page.dart';
import 'package:easy_scanner/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgetElements.commonAppBar(title: 'Ezi Scanner'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vertical20,
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    level: 'Scan \n QR Code',
                    onTap: () {
                      Get.toNamed(Routes.BARCODE_SCANNER, arguments: "qrcode")
                          ?.then((value) {
                        if (value != null) {
                          ms.Barcode barcode = value as ms.Barcode;
                          Get.toNamed(
                            Routes.SCANNER_DETAILS,
                            arguments: barcode,
                          );
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    level: 'Scan \n BAR Code',
                    onTap: () {
                      Get.toNamed(Routes.BARCODE_SCANNER, arguments: "barcode")
                          ?.then((value) {
                        if (value != null) {
                          ms.Barcode barcode = value as ms.Barcode;
                          Get.toNamed(
                            Routes.SCANNER_DETAILS,
                            arguments: barcode,
                          );
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.view_quilt_sharp,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    level: 'Scan \n Business Card',
                    onTap: controller.onBusinessCardScan,
                    icon: const Icon(
                      Icons.view_comfortable_outlined,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    level: 'Scan Image',
                    onTap: () async {
                      await controller.pickAndScanImage();
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  level: 'Generate \n QR or Barcode',
                  onTap: () {
                    Get.toNamed(Routes.CREATE_QR_CODE);
                  },
                  icon: const Icon(
                    Icons.qr_code,
                    color: Colors.blue,
                    size: 50,
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    level: 'History',
                    onTap: () {
                      Get.toNamed(Routes.HISTORY);
                    },
                    icon: const Icon(
                      Icons.history,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
