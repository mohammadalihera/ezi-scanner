import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class EmailDetailsView extends StatelessWidget {
  final Barcode barcode;
  final EmailData emailData;
  const EmailDetailsView({
    super.key,
    required this.barcode,
    required this.emailData,
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
                      const Icon(Icons.email_outlined, size: 25),
                      horizontal4,
                      Text(
                        'Email Details',
                        style: AppTextStyles.h4Bold,
                      ),
                    ],
                  ),
                  vertical12,
                  LabelValueWidget(
                    label: "Email",
                    value: emailData.email ?? 'N/A',
                    icon: Icon(Icons.email),
                  ),
                  vertical4,
                  LabelValueWidget(
                    label: "Sub",
                    value: emailData.sub ?? 'N/A',
                    // icon: Icon(Icons.subject),
                  ),
                  LabelValueWidget(
                    label: "Body",
                    value: emailData.sub ?? 'N/A',
                    // icon: Icon(Icons.description),
                  ),
                  vertical20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidgetElements.sendEmail(
                        email: emailData.email!,
                        sub: emailData.sub,
                        body: emailData.body,
                      ),
                      vertical12,
                      CustomWidgetElements.copyButton(emailData.toString()),
                      vertical12,
                      CustomWidgetElements.shareButton(emailData.toString()),
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
