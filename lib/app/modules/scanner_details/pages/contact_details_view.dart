import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;

import 'package:get/get.dart';

class ContactDetailsView extends StatelessWidget {
  final b_w.BarcodeWidget barcode;
  final BusinessCardModel contactData;
  const ContactDetailsView({
    super.key,
    required this.barcode,
    required this.contactData,
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
                      const Icon(Icons.contact_emergency_outlined, size: 25),
                      horizontal4,
                      Text(
                        'Contact Details',
                        style: AppTextStyles.h4Bold,
                      ),
                    ],
                  ),
                  LabelValueWidget(
                    label: "Name",
                    value: contactData.name ?? 'N/A',
                    icon: Icon(Icons.person),
                  ),
                  LabelValueWidget(
                    label: "Phone",
                    value: contactData.phone ?? 'N/A',
                    icon: Icon(Icons.phone),
                  ),
                  LabelValueWidget(
                    label: "Email",
                    value: contactData.email ?? 'N/A',
                    icon: Icon(Icons.email_outlined),
                  ),
                  LabelValueWidget(
                    label: "Company",
                    value: contactData.company ?? 'N/A',
                    icon: Icon(Icons.business),
                  ),
                  LabelValueWidget(
                    label: "Address",
                    value: contactData.address ?? '',
                    icon: Icon(Icons.location_city),
                  ),
                  LabelValueWidget(
                    label: "Website",
                    value: contactData.website ?? '',
                    icon: Icon(Icons.link),
                  ),
                  vertical12,
                  vertical20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidgetElements.dialButton(contactData),
                      vertical12,
                      CustomWidgetElements.sendSms(contactData),
                      vertical12,
                      CustomWidgetElements.createContact(contactData),
                      vertical12,
                      if (contactData.email != null)
                        Column(
                          children: [
                            CustomWidgetElements.sendEmail(contactData),
                            vertical12,
                          ],
                        ),
                      if (contactData.website != null)
                        Column(
                          children: [
                            CustomWidgetElements.browseButton(
                              context,
                              contactData.website ?? '',
                            ),
                            vertical12,
                          ],
                        ),
                      CustomWidgetElements.copyButton(contactData.toString()),
                      vertical12,
                      CustomWidgetElements.shareButton(contactData.toString()),
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
