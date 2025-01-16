import 'package:easy_scanner/app/modules/business_card_details/bindings/business_card_details_binding.dart';
import 'package:easy_scanner/app/modules/business_card_details/views/business_card_details_view.dart';
import 'package:get/get.dart';
import '../modules/create_bar_code/bindings/create_bar_code_binding.dart';
import '../modules/create_bar_code/views/create_bar_code_view.dart';
import '../modules/create_qr_code/bindings/create_qr_code_binding.dart';
import '../modules/create_qr_code/views/create_qr_code_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/scanner_details/bindings/scanner_details_binding.dart';
import '../modules/scanner_details/pages/barcode_scanner/bindings/barcode_scanner_binding.dart';
import '../modules/scanner_details/pages/barcode_scanner/views/barcode_scanner_view.dart';
import '../modules/scanner_details/views/scanner_details_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER_DETAILS,
      page: () => const ScannerDetailsView(),
      binding: ScannerDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_QR_CODE,
      page: () => const CreateQrCodeView(),
      binding: CreateQrCodeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BAR_CODE,
      page: () => const CreateBarCodeView(),
      binding: CreateBarCodeBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_CARD_DETAILS,
      page: () => const BusinessCardDetailsView(),
      binding: BusinessCardDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BARCODE_SCANNER,
      page: () => const BarcodeScannerView(),
      binding: BarcodeScannerBinding(),
    ),
  ];
}
