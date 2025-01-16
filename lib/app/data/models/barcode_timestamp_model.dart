import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeTimeStampModel {
  final Barcode barcode;
  final DateTime dateTime;

  BarcodeTimeStampModel({
    required this.barcode,
    required this.dateTime,
  });
}
