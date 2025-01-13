import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;

import 'package:get/get.dart';

class CalendarEventDetailsView extends StatelessWidget {
  final b_w.BarcodeWidget barcode;
  final EventData eventData;
  const CalendarEventDetailsView({
    super.key,
    required this.barcode,
    required this.eventData,
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
                      const Icon(Icons.event, size: 25),
                      horizontal4,
                      Text(
                        'Event Details',
                        style: AppTextStyles.h4Bold,
                      ),
                    ],
                  ),
                  LabelValueWidget(label: "Title", value: eventData.title),
                  LabelValueWidget(
                    label: "Start",
                    value: eventData.startDate.toWrittenFormat(),
                  ),
                  LabelValueWidget(
                    label: "End",
                    value: eventData.endDate.toWrittenFormat(),
                  ),
                  LabelValueWidget(
                    label: "Location",
                    value: eventData.location,
                  ),
                  LabelValueWidget(
                    label: "Description",
                    value: eventData.description,
                  ),
                  vertical12,
                  vertical20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidgetElements.copyButton(eventData.toString()),
                      vertical12,
                      CustomWidgetElements.makeEvent(context, eventData),
                      vertical12,
                      CustomWidgetElements.shareButton(eventData.toString()),
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
