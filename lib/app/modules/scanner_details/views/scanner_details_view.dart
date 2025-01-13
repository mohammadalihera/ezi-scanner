import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';
import 'package:easy_scanner/app/data/models/wifi_data.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/calendar_event_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/contact_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/location_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/website_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/wifi_details_view.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as m_s;
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/scanner_details_controller.dart';

class ScannerDetailsView extends GetView<ScannerDetailsController> {
  const ScannerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final barcode = b_w.BarcodeWidget(
      data: controller.barcode?.rawValue ?? "",
      barcode: b_w.Barcode.fromType(
        controller.getBarcodeType(
                controller.barcode?.format ?? BarcodeFormat.qrCode) ??
            b_w.BarcodeType.QrCode,
      ),
      width: 200,
    );
    return Scaffold(
        appBar: CustomWidgetElements.commonAppBar(
          title: controller.barcode?.type.name.toUpperCase() ?? '',
          back: true,
        ),
        body: Obx(() {
          print(controller.type.value);
          if (controller.barcode?.type == m_s.BarcodeType.url) {
            return WebsiteDetailsView(
                url: controller.barcode?.rawValue ?? '', barcode: barcode);
          }

          if (controller.barcode?.type == m_s.BarcodeType.geo) {
            return LocationDetailsView(
                url: controller.barcode?.rawValue ?? '', barcode: barcode);
          }

          if (controller.barcode?.type == m_s.BarcodeType.calendarEvent) {
            return CalendarEventDetailsView(
              barcode: barcode,
              eventData:
                  EventData.parseEvent(controller.barcode?.rawValue ?? ''),
            );
          }
          if (controller.barcode?.type == m_s.BarcodeType.contactInfo) {
            return ContactDetailsView(
              barcode: barcode,
              contactData: BusinessCardModel.parseContact(
                controller.barcode?.rawValue ?? '',
              ),
            );
          }

          if (controller.barcode?.type == m_s.BarcodeType.wifi) {
            return WifiDetailsView(
              barcode: barcode,
              wifiData: WifiData.parseWifiData(
                controller.barcode?.rawValue ?? '',
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vertical20,
                  BarcodeView(barcode: barcode),
                  vertical16,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    width: Get.size.width,
                    decoration:
                        CustomWidgetElements.commonDecorationWithShadow(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Value: ${controller.barcode?.rawValue ?? ""}'),
                        const SizedBox(height: 8),
                        Text('Type: ${controller.barcode?.type ?? ""}'),
                        const SizedBox(height: 8),
                        Text('Format: ${controller.barcode?.format ?? ""}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
