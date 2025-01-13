import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/label_value_widget.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';
import 'package:easy_scanner/app/data/models/wifi_data.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;

import 'package:get/get.dart';

class WifiDetailsView extends StatelessWidget {
  final b_w.BarcodeWidget barcode;
  final WifiData wifiData;
  const WifiDetailsView({
    super.key,
    required this.barcode,
    required this.wifiData,
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
                        'Wifi Details',
                        style: AppTextStyles.h4Bold,
                      ),
                    ],
                  ),
                  LabelValueWidget(
                    label: "Name",
                    value: wifiData.name,
                    icon: Icon(Icons.wifi),
                  ),
                  LabelValueWidget(
                    label: "Password",
                    value: wifiData.password,
                    icon: Icon(Icons.lock),
                  ),
                  LabelValueWidget(
                    label: "Type",
                    value: wifiData.type,
                    icon: Icon(Icons.security),
                  ),
                  vertical20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidgetElements.connectWifi(wifiData),
                      vertical12,
                      CustomWidgetElements.copyButton(wifiData.toString()),
                      vertical12,
                      CustomWidgetElements.shareButton(wifiData.toString()),
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
