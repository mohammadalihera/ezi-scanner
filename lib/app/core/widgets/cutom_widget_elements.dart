import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/services/calendar_service.dart';
import 'package:easy_scanner/app/core/services/common_services.dart';
import 'package:easy_scanner/app/core/services/contact_service.dart';
import 'package:easy_scanner/app/core/widgets/app_button.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:easy_scanner/app/data/models/event_data.dart';
import 'package:easy_scanner/app/data/models/wifi_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:mobile_scanner/mobile_scanner.dart';

class CustomWidgetElements {
  static commonAppBar({
    required String title,
    bool back = false,
    List<Widget>? actionWidgets,
  }) {
    return AppBar(
      // elevation: 3,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[50],
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: back
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: actionWidgets,
    );
  }

  static commonDecorationWithShadow({
    BorderRadius? radius,
    Color color = Colors.white,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: radius ?? radius10,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
          blurStyle: BlurStyle.normal,
          offset: Offset(3, 3),
        ),
      ],
    );
  }

  static commonDecoration({
    BorderRadius? radius,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: radius ?? radius10,
    );
  }

  static Widget copyButton(String item) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Copy',
      onTap: () => CommonServices.copyToClipboard(item),
      icon: const Icon(Icons.copy),
      textColor: Colors.white,
      buttonColor: Colors.blue,
    );
  }

  static Widget browseButton(BuildContext context, String url) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Browse',
      onTap: () async => await CommonServices.openInBrowser(context, url),
      icon: const Icon(Icons.link_outlined),
      textColor: Colors.white,
      buttonColor: Colors.orange,
    );
  }

  static Widget makeEvent(BuildContext context, EventData event) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Make Event',
      onTap: () async => await CalendarService().createCalendarEvent(event),
      icon: const Icon(Icons.event_note),
      textColor: Colors.white,
      buttonColor: Colors.orange,
    );
  }

  static Widget shareButton(String item) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Share',
      onTap: () => CommonServices.share(item),
      icon: const Icon(Icons.share),
      textColor: Colors.white,
      buttonColor: Colors.green[600],
    );
  }

  static Widget createContact(BusinessCardModel businessCardModel) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Create Contact',
      onTap: () => ContactService.createNewContact(businessCardModel),
      icon: const Icon(Icons.contact_phone),
      textColor: Colors.white,
      buttonColor: Colors.yellow[800],
    );
  }

  static Widget dialButton(String phone) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Dial $phone',
      onTap: () async => await ContactService.dialNumber(phone),
      icon: const Icon(Icons.phone),
      textColor: Colors.white,
      buttonColor: Colors.red[400],
    );
  }

  static Widget sendSms({required String phone, String? sms}) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Send SMS',
      onTap: () async => await ContactService.sendSMS(phone, sms),
      icon: const Icon(Icons.sms_outlined),
      textColor: Colors.white,
      buttonColor: Colors.orange[300],
    );
  }

  static Widget sendEmail({required String email, String? sub, String? body}) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Send Email',
      onTap: () async => await ContactService.sendEmail(
        email: email,
        sub: sub,
        body: body,
      ),
      icon: const Icon(Icons.email_outlined),
      textColor: Colors.white,
      buttonColor: Colors.orange[400],
    );
  }

  static Widget mapButton(BuildContext context, String url) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Open Map',
      onTap: () => CommonServices.openInBrowser(context, url),
      icon: const Icon(Icons.location_searching_outlined),
      textColor: Colors.white,
      buttonColor: Colors.red[400],
    );
  }

  static Widget copyWifiPassword(WifiData wifiData) {
    return AppButton(
      height: 50,
      width: Get.width,
      name: 'Copy Password',
      onTap: () => CommonServices.copyToClipboard(wifiData.password),
      icon: const Icon(Icons.wifi),
      textColor: Colors.white,
      buttonColor: Colors.red[400],
    );
  }

  static Widget sourceCodeView(b_w.BarcodeWidget barcode) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: CustomWidgetElements.commonDecorationWithShadow(),
        child: Stack(
          children: [
            barcode,
            Positioned(
              left: 70,
              top: 70,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: commonDecoration(
                    radius: BorderRadius.circular(25),
                    color: Colors.green[600]!.withOpacity(0.8),
                  ),
                  child: const Icon(
                    Icons.download_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
