import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as m_s;

abstract class AppUtils {
  static IconData getIconForBarcode(m_s.Barcode barcode) {
    switch (barcode.type) {
      case m_s.BarcodeType.unknown:
        return Icons.help;
      case m_s.BarcodeType.contactInfo:
        return Icons.contact_phone;
      case m_s.BarcodeType.email:
        return Icons.email;
      case m_s.BarcodeType.isbn:
        return Icons.book;
      case m_s.BarcodeType.phone:
        return Icons.phone;
      case m_s.BarcodeType.product:
        return Icons.shopping_cart;
      case m_s.BarcodeType.sms:
        return Icons.sms;
      case m_s.BarcodeType.text:
        return Icons.text_snippet;
      case m_s.BarcodeType.url:
        return Icons.link;
      case m_s.BarcodeType.wifi:
        return Icons.wifi;
      case m_s.BarcodeType.geo:
        return Icons.map;
      case m_s.BarcodeType.calendarEvent:
        return Icons.event;
      case m_s.BarcodeType.driverLicense:
        return Icons.badge;
    }
  }

  static String getInfoForBarcode(m_s.Barcode barcode) {
    switch (barcode.type) {
      case m_s.BarcodeType.unknown:
        return "Unknown type";
      case m_s.BarcodeType.contactInfo:
        return barcode.contactInfo?.name?.formattedName ?? "Contact Info";
      case m_s.BarcodeType.email:
        return barcode.email?.address ?? "Email";
      case m_s.BarcodeType.isbn:
        return barcode.displayValue ?? "ISBN";
      case m_s.BarcodeType.phone:
        return barcode.phone?.number ?? "Phone Number";
      case m_s.BarcodeType.product:
        return barcode.displayValue ?? "Product";
      case m_s.BarcodeType.sms:
        return barcode.sms?.message ?? "SMS";
      case m_s.BarcodeType.text:
        return barcode.displayValue ?? "Text";
      case m_s.BarcodeType.url:
        return barcode.url?.url ?? "URL";
      case m_s.BarcodeType.wifi:
        return "WiFi: ${barcode.wifi?.ssid ?? "Unknown"}";
      case m_s.BarcodeType.geo:
        return "Geo: ${barcode.geoPoint?.latitude}, ${barcode.geoPoint?.longitude}";
      case m_s.BarcodeType.calendarEvent:
        return barcode.calendarEvent?.summary ?? "Calendar Event";
      case m_s.BarcodeType.driverLicense:
        return '${barcode.driverLicense?.firstName} ${barcode.driverLicense?.lastName}';
      default:
        return "No information available";
    }
  }

  static Map<b_w.BarcodeType, m_s.BarcodeFormat> barcodeMapping = {
    b_w.BarcodeType.Code128: m_s.BarcodeFormat.code128,
    b_w.BarcodeType.Code39: m_s.BarcodeFormat.code39,
    b_w.BarcodeType.Code93: m_s.BarcodeFormat.code93,
    b_w.BarcodeType.Codabar: m_s.BarcodeFormat.codabar,
    b_w.BarcodeType.DataMatrix: m_s.BarcodeFormat.dataMatrix,
    b_w.BarcodeType.CodeEAN13: m_s.BarcodeFormat.ean13,
    b_w.BarcodeType.CodeEAN8: m_s.BarcodeFormat.ean8,
    b_w.BarcodeType.Itf: m_s.BarcodeFormat.itf,
    b_w.BarcodeType.QrCode: m_s.BarcodeFormat.qrCode,
    b_w.BarcodeType.CodeUPCA: m_s.BarcodeFormat.upcA,
    b_w.BarcodeType.CodeUPCE: m_s.BarcodeFormat.upcE,
    b_w.BarcodeType.PDF417: m_s.BarcodeFormat.pdf417,
    b_w.BarcodeType.Aztec: m_s.BarcodeFormat.aztec,
  };

  static b_w.BarcodeType? getBarcodeType(m_s.BarcodeFormat format) {
    return barcodeMapping.entries
        .firstWhere((entry) => entry.value == format)
        .key;
  }

  static b_w.Barcode convertBarcodeMsToBw(m_s.Barcode barcode) {
    final barcodeType = barcodeMapping.entries
        .firstWhere((entry) => entry.value == barcode.format)
        .key;

    return b_w.Barcode.fromType(barcodeType);
  }
}
