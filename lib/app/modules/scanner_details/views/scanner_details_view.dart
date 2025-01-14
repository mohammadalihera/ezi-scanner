import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';
import 'package:easy_scanner/app/data/models/wifi_data.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/calendar_event_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/contact_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/default_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/email_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/location_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/sms_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/website_details_view.dart';
import 'package:easy_scanner/app/modules/scanner_details/pages/wifi_details_view.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as m_s;
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/scanner_details_controller.dart';

class ScannerDetailsView extends GetView<ScannerDetailsController> {
  const ScannerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomWidgetElements.commonAppBar(
          title: controller.barcode.value?.type.name.toUpperCase() ?? '',
          back: true,
        ),
        body: Obx(() {
          print(controller.type.value);

          if (controller.barcode.value == null) {
            return const SizedBox.shrink();
          }

          final barcode = b_w.BarcodeWidget(
            data: controller.barcode.value?.rawValue ?? "",
            barcode: b_w.Barcode.fromType(
              controller.getBarcodeType(
                  controller.barcode.value?.format ?? BarcodeFormat.qrCode) ??
                  b_w.BarcodeType.QrCode,
            ),
            width: 200,
          );

          if (controller.barcode.value?.type == m_s.BarcodeType.url) {
            return WebsiteDetailsView(
              url: controller.barcode.value?.rawValue ?? '',
              barcode: barcode,
            );
          }

          if (controller.barcode.value?.type == m_s.BarcodeType.geo) {
            return LocationDetailsView(
              url: controller.barcode.value?.rawValue ?? '',
              barcode: barcode,
            );
          }

          if (controller.barcode.value?.type == m_s.BarcodeType.calendarEvent) {
            return CalendarEventDetailsView(
              barcode: barcode,
              eventData: EventData.parseEvent(
                  controller.barcode.value?.rawValue ?? ''),
            );
          }
          if (controller.barcode.value?.type == m_s.BarcodeType.contactInfo) {
            return ContactDetailsView(
              barcode: barcode,
              contactData: BusinessCardModel.parseContact(
                controller.barcode.value?.rawValue ?? '',
              ),
            );
          }

          if (controller.barcode.value?.type == m_s.BarcodeType.wifi) {
            return WifiDetailsView(
              barcode: barcode,
              wifiData: WifiData.parseWifiData(
                controller.barcode.value?.rawValue ?? '',
              ),
            );
          }

          if (controller.barcode.value?.type == m_s.BarcodeType.sms) {
            return SmsDetailsView(
              barcode: barcode,
              smsData: SmsData.parseSms(
                controller.barcode.value?.rawValue ?? '',
              ),
            );
          }

          if (controller.barcode.value?.type == m_s.BarcodeType.email) {
            return EmailDetailsView(
              barcode: barcode,
              emailData: EmailData.parseEmail(
                controller.barcode.value?.rawValue ?? '',
              ),
            );
          }

          return DefaultDetailsView(
            barcode: barcode,
            data: controller.barcode.value?.rawValue ?? '',
            isBar: controller.isBar,
          );
        }));
  }
}
