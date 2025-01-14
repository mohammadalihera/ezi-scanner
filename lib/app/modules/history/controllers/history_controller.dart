import 'package:easy_scanner/app/core/services/storage_service.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HistoryController extends GetxController {
  Rx<int> currentTab = 0.obs;
  PageController pageController = PageController();

  Rx<List<Barcode>> barcodeList = Rx([]);
  Rx<List<BusinessCardModel>> businessCardModel = Rx([]);

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
    barcodeList.value = StorageService().getBarcodeList();
    businessCardModel.value = StorageService().getBusinessCardList();
  }
}
