import 'package:easy_scanner/app/core/services/storage_service.dart';
import 'package:easy_scanner/app/data/models/barcode_timestamp_model.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HistoryController extends GetxController {
  Rx<int> currentTab = 0.obs;
  PageController pageController = PageController();

  Rx<List<BarcodeTimeStampModel>> barcodeTimeStampList = Rx([]);
  Rx<List<BusinessCardModel>> businessCardList = Rx([]);

  List<String> tabTitle = [
    'Barcode',
    'Card',
  ];

  @override
  onInit() {
    super.onInit();
    fetchHistoryData();
  }

  onTabChange(int index) {
    currentTab.value = index;
  }

  fetchHistoryData() {
    barcodeTimeStampList.value = StorageService().getBarcodeList();
    businessCardList.value = StorageService().getBusinessCardList();
  }
}
