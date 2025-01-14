import 'package:easy_scanner/app/data/models/wifi_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wifi_iot/wifi_iot.dart';

class CommonServices {
  static void copyToClipboard(String url) {
    Clipboard.setData(ClipboardData(text: url));
    Get.snackbar('Copied to clipboard', url);
  }

  static Future<void> openInBrowser(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Can not launch the url')),
      );
    }
  }

  static void share(String shareString) {
    try {
      Share.share(' $shareString');
    } catch (e) {
      print(e);
    }
  }

  static Future<void> connectToWifi(WifiData wifiData) async {
    final isConnected = await WiFiForIoTPlugin.connect(wifiData.name,
        password: wifiData.password,
        security:
            wifiData.type == 'WPA' ? NetworkSecurity.WPA : NetworkSecurity.WEP);

    if (isConnected) {
      Get.snackbar('Connect To Wifi', '${wifiData.name} connect successfully');
    } else {
      Get.snackbar('Connect To Wifi', '${wifiData.name} failed to connect');
    }
  }
}
