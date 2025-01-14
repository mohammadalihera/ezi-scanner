import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_scanner/app/data/models/barcode_spec.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateService {
  List<BarcodeType> getQrBarcodeTypeList() =>
      BarcodeType.values.map((e) => e).toList();

  Future<String> saveBarcode({
    required BarcodeType type,
    required String content,
    double width = 200,
    double height = 200,
  }) async {
    try {
      Barcode bc;
      bc = Barcode.fromType(type);

      final svgStringData = bc.toSvg(
        content,
        width: width,
        height: height,
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/barcode_${type.name}_${DateTime.now().microsecondsSinceEpoch}.svg';

      final file = File(filePath);
      await file.writeAsString(svgStringData);

      return filePath;
    } catch (e) {
      if (kDebugMode) {
        print("Error saving Qr code: $e");
      }
      return "";
    }
  }

  Future<String> saveQrCode(String data) async {
    try {
      final qrPainter = QrPainter(
        data: data,
        version: QrVersions.auto,
        eyeStyle: QrEyeStyle(
          color: const Color(0xff000000),
          eyeShape: QrEyeShape.square,
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png';

      final imageData = await qrPainter.toImageData(200.0);
      final bytes = imageData;

      final file = File(path);
      await file.writeAsBytes(bytes!.buffer.asUint8List());

      return path;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to save QR code: $e");
      }
      return "";
    }
  }

  // Get barcode specifications
  BarcodeSpec getBarcodeSpecs(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 16,
          maxLength: 16,
        );
      case BarcodeType.CodeITF14:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 14,
          maxLength: 14,
        );
      case BarcodeType.CodeEAN13:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 13,
          maxLength: 13,
        );
      case BarcodeType.CodeEAN8:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 8,
          maxLength: 8,
        );
      case BarcodeType.CodeEAN5:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 5,
          maxLength: 5,
        );
      case BarcodeType.CodeEAN2:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 2,
          maxLength: 2,
        );
      case BarcodeType.CodeISBN:
        return BarcodeSpec(
          acceptedData:
              "Numeric only (0-9), with optional 'X' as the check digit",
          minLength: 10,
          maxLength: 13,
        );
      case BarcodeType.Code39:
        return BarcodeSpec(
          acceptedData: "A-Z, 0-9, -, ., space, \$, /, +, %",
          minLength: 1,
          maxLength: 43,
        );
      case BarcodeType.Code93:
        return BarcodeSpec(
          acceptedData: "A-Z, 0-9, -, ., space, \$, /, +, %",
          minLength: 1,
          maxLength: 43,
        );
      case BarcodeType.CodeUPCA:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 12,
          maxLength: 12,
        );
      case BarcodeType.CodeUPCE:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 6,
          maxLength: 8,
        );
      case BarcodeType.Code128:
        return BarcodeSpec(
          acceptedData: "All ASCII characters (0-127)",
          minLength: 1,
          maxLength: 80,
        );
      case BarcodeType.GS128:
        return BarcodeSpec(
          acceptedData: "All ASCII characters with GS1 formatting",
          minLength: 1,
          maxLength: 48,
        );
      case BarcodeType.Telepen:
        return BarcodeSpec(
          acceptedData: "All ASCII characters",
          minLength: 1,
          maxLength: 64,
        );
      case BarcodeType.QrCode:
        return BarcodeSpec(
          acceptedData: "Numeric, alphanumeric, binary, Kanji",
          minLength: 1,
          maxLength: 4296,
        );
      case BarcodeType.Codabar:
        return BarcodeSpec(
          acceptedData:
              "0-9, -, \$, :, /, ., + (must start and end with A, B, C, or D)",
          minLength: 2,
          maxLength: 60,
        );
      case BarcodeType.PDF417:
        return BarcodeSpec(
          acceptedData: "All ASCII characters",
          minLength: 1,
          maxLength: 1850,
        );
      case BarcodeType.DataMatrix:
        return BarcodeSpec(
          acceptedData: "All ASCII characters",
          minLength: 1,
          maxLength: 2335,
        );
      case BarcodeType.Aztec:
        return BarcodeSpec(
          acceptedData: "All ASCII characters",
          minLength: 1,
          maxLength: 3067,
        );
      case BarcodeType.Rm4scc:
        return BarcodeSpec(
          acceptedData: "A-Z, 0-9",
          minLength: 2,
          maxLength: 20,
        );
      case BarcodeType.Itf:
        return BarcodeSpec(
          acceptedData: "Numeric only (0-9)",
          minLength: 2,
          maxLength: 30,
        );
    }
  }

  // Convert BarcodeType to Barcode format
  Barcode getBarcodeFormat(BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
      case BarcodeType.CodeITF14:
      case BarcodeType.Itf:
        return Barcode.itf();
      case BarcodeType.CodeEAN13:
        return Barcode.ean13();
      case BarcodeType.CodeEAN8:
        return Barcode.ean8();
      case BarcodeType.CodeEAN5:
        return Barcode.ean5();
      case BarcodeType.CodeEAN2:
        return Barcode.ean2();
      case BarcodeType.CodeISBN:
        return Barcode.isbn();
      case BarcodeType.Code39:
        return Barcode.code39();
      case BarcodeType.Code93:
        return Barcode.code93();
      case BarcodeType.CodeUPCA:
        return Barcode.upcA();
      case BarcodeType.CodeUPCE:
        return Barcode.upcE();
      case BarcodeType.Code128:
        return Barcode.code128();
      case BarcodeType.GS128:
        return Barcode.gs128();
      case BarcodeType.Telepen:
        return Barcode.telepen();
      case BarcodeType.QrCode:
        return Barcode.qrCode();
      case BarcodeType.Codabar:
        return Barcode.codabar();
      case BarcodeType.PDF417:
        return Barcode.pdf417();
      case BarcodeType.DataMatrix:
        return Barcode.dataMatrix();
      case BarcodeType.Aztec:
        return Barcode.aztec();
      case BarcodeType.Rm4scc:
        return Barcode.rm4scc();
    }
  }

  // Get friendly name for dropdown
  String getBarcodeTypeName(BarcodeType type) {
    return type
        .toString()
        .split('.')
        .last
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(0)}',
        )
        .trim();
  }
}
