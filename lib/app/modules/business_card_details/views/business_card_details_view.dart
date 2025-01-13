import 'dart:io';

import 'package:easy_scanner/app/core/constants/app_colors.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/services/image_picker_service.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/business_card_details_controller.dart';

class BusinessCardDetailsView extends GetView<BusinessCardDetailsController> {
  const BusinessCardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgetElements.commonAppBar(
          title: 'Business Card',
          back: true,
          actionWidgets: [
            Padding(
              padding: const EdgeInsets.only(right: size10),
              child: GestureDetector(
                onTap: controller.pickImageAndScanText,
                child: const Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ]),
      body: Obx(() {
        if (controller.businessCardModel.value != null &&
            controller.imagePath.value != null) {
          final cardModel = controller.businessCardModel.value!;

          return Padding(
            padding: const EdgeInsets.all(size16),
            child: SingleChildScrollView(
              child: Container(
                width: Get.size.width,
                decoration: CustomWidgetElements.commonDecorationWithShadow(),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    Container(
                      width: double.infinity,
                      height: Get.width * 0.5,
                      padding: EdgeInsets.all(10),
                      decoration:
                          CustomWidgetElements.commonDecorationWithShadow(),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.file(
                              File(controller.imageFileValue),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () => controller.saveCardImage(),
                              child: Container(
                                padding: EdgeInsets.all(size10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green[600]!.withOpacity(0.8),
                                ),
                                child: Icon(
                                  Icons.download,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    vertical16,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelValueWidget(
                              label: "Name", value: cardModel.name ?? 'N/A'),
                          LabelValueWidget(
                              label: "Phone", value: cardModel.phone ?? 'N/A'),
                          LabelValueWidget(
                              label: "Email", value: cardModel.email ?? 'N/A'),
                          LabelValueWidget(
                              label: "Address",
                              value: cardModel.address ?? 'N/A'),
                          LabelValueWidget(
                              label: "Company",
                              value: cardModel.company ?? 'N/A'),
                          LabelValueWidget(
                              label: "Website",
                              value: cardModel.website ?? 'N/A'),
                        ],
                      ),
                    ),
                    vertical16,

                    CustomWidgetElements.createContact(cardModel),
                    vertical12,
                    CustomWidgetElements.copyButton(cardModel.toString()),
                    vertical12,
                    CustomWidgetElements.shareButton(cardModel.toString()),
                    vertical12,
                  ],
                ),
              ),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Obx(() {
                return GestureDetector(
                  onTap: controller.inProgress.value
                      ? null
                      : controller.pickImageAndScanText,
                  child: Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: controller.inProgress.value
                        ? CircularProgressIndicator(color: AppColors.primary100)
                        : Icon(Icons.add, color: AppColors.primary100),
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
