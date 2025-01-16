import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SmsDetailsView extends StatelessWidget {
  final Barcode barcode;
  final SmsData smsData;
  const SmsDetailsView({
    super.key,
    required this.barcode,
    required this.smsData,
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
                      const Icon(Icons.system_security_update_good_outlined,
                          size: 25),
                      horizontal4,
                      Text(
                        'SMS Details',
                        style: AppTextStyles.h4Bold,
                      ),
                    ],
                  ),
                  vertical12,
                  LabelValueWidget(
                    label: "Phone",
                    value: smsData.phone ?? 'N/A',
                    icon: Icon(Icons.phone),
                  ),
                  vertical4,
                  LabelValueWidget(
                    label: "SMS",
                    value: smsData.sms ?? 'N/A',
                    icon: Icon(Icons.sms_outlined),
                  ),
                  vertical20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidgetElements.dialButton(smsData.phone!),
                      vertical12,
                      CustomWidgetElements.sendSms(
                        phone: smsData.phone!,
                        sms: smsData.sms,
                      ),
                      vertical12,
                      CustomWidgetElements.createContact(
                        BusinessCardModel(phone: smsData.phone),
                      ),
                      vertical12,
                      CustomWidgetElements.copyButton(smsData.toString()),
                      vertical12,
                      CustomWidgetElements.shareButton(smsData.toString()),
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
