import 'package:barcode_widget/barcode_widget.dart';

class BarcodeValidator {
  static final RegExp _itf16 = RegExp(r'^\d{16}$');
  static final RegExp _itf14 = RegExp(r'^\d{14}$');
  static final RegExp _ean13 = RegExp(r'^\d{13}$');
  static final RegExp _ean8 = RegExp(r'^\d{8}$');
  static final RegExp _ean5 = RegExp(r'^\d{5}$');
  static final RegExp _ean2 = RegExp(r'^\d{2}$');
  static final RegExp _isbn = RegExp(
      r'^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$');
  static final RegExp _code39 = RegExp(r'^[A-Z0-9\-\. \$\/\+\%]*$');
  static final RegExp _code93 = RegExp(r'^[A-Z0-9\-\. \$\/\+\%]*$');
  static final RegExp _upcA = RegExp(r'^\d{12}$');
  static final RegExp _upcE = RegExp(r'^\d{6,8}$');
  static final RegExp _code128 = RegExp(r'^[\x00-\x7F]+$');
  static final RegExp _gs128 = RegExp(r'^\([0-9]{2,4}\)[0-9A-Za-z]+$');
  static final RegExp _telepen = RegExp(r'^[\x00-\x7F]+$');
  static final RegExp _qrCode = RegExp(r'^[\x00-\xFF]+$');
  static final RegExp _codabar = RegExp(r'^[A-D][0-9\-\$\:\/\.]+[A-D]$');
  static final RegExp _pdf417 = RegExp(r'^[\x00-\xFF]+$');
  static final RegExp _dataMatrix = RegExp(r'^[\x00-\xFF]+$');
  static final RegExp _aztec = RegExp(r'^[\x00-\xFF]+$');
  static final RegExp _rm4scc = RegExp(r'^[A-Z0-9]{2,20}$');
  static final RegExp _itf = RegExp(r'^\d{2,30}$');

  static bool isValidBarcode(String input, BarcodeType type) {
    switch (type) {
      case BarcodeType.CodeITF16:
        return _itf16.hasMatch(input);
      case BarcodeType.CodeITF14:
        return _itf14.hasMatch(input);
      case BarcodeType.CodeEAN13:
        return _ean13.hasMatch(input);
      case BarcodeType.CodeEAN8:
        return _ean8.hasMatch(input);
      case BarcodeType.CodeEAN5:
        return _ean5.hasMatch(input);
      case BarcodeType.CodeEAN2:
        return _ean2.hasMatch(input);
      case BarcodeType.CodeISBN:
        return _isbn.hasMatch(input);
      case BarcodeType.Code39:
        return _code39.hasMatch(input);
      case BarcodeType.Code93:
        return _code93.hasMatch(input);
      case BarcodeType.CodeUPCA:
        return _upcA.hasMatch(input);
      case BarcodeType.CodeUPCE:
        return _upcE.hasMatch(input);
      case BarcodeType.Code128:
        return _code128.hasMatch(input);
      case BarcodeType.GS128:
        return _gs128.hasMatch(input);
      case BarcodeType.Telepen:
        return _telepen.hasMatch(input);
      case BarcodeType.QrCode:
        return _qrCode.hasMatch(input);
      case BarcodeType.Codabar:
        return _codabar.hasMatch(input);
      case BarcodeType.PDF417:
        return _pdf417.hasMatch(input);
      case BarcodeType.DataMatrix:
        return _dataMatrix.hasMatch(input);
      case BarcodeType.Aztec:
        return _aztec.hasMatch(input);
      case BarcodeType.Rm4scc:
        return _rm4scc.hasMatch(input);
      case BarcodeType.Itf:
        return _itf.hasMatch(input);
    }
  }
}
