import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/string_validation_extensions.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DefaultDetailsView extends StatelessWidget {
  final Barcode barcode;
  final String data;

  const DefaultDetailsView({
    super.key,
    required this.barcode,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.size.width,
              decoration: CustomWidgetElements.commonDecorationWithShadow(),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BarcodeView(barcode: barcode),
                  vertical20,
                  Row(
                    children: [
                      const Icon(Icons.text_snippet, size: 25),
                      horizontal4,
                      Text(
                        'Details',
                        style: AppTextStyles.h4Bold,
                      ),
                    ],
                  ),
                  vertical12,
                  LabelValueWidget(
                    label: "Text",
                    value: data,
                  ),
                  vertical20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.isValidPhoneNumber)
                        Column(
                          children: [
                            CustomWidgetElements.dialButton(data),
                            vertical12,
                            CustomWidgetElements.sendSms(phone: data),
                            vertical12,
                            CustomWidgetElements.createContact(
                              BusinessCardModel(phone: data),
                            ),
                            vertical12,
                          ],
                        ),
                      if (data.isValidEmail)
                        Column(
                          children: [
                            CustomWidgetElements.sendEmail(email: data),
                            vertical12,
                          ],
                        ),
                      if (data.isValidUrl)
                        Column(
                          children: [
                            CustomWidgetElements.browseButton(context, data),
                            vertical12,
                          ],
                        ),
                      CustomWidgetElements.copyButton(data.toString()),
                      vertical12,
                      CustomWidgetElements.shareButton(data.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
