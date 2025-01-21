import 'dart:convert';

import 'package:easy_scanner/app/core/constants/app_string_constants.dart';
import 'package:easy_scanner/app/core/extensions/app_barcode_extension.dart';
import 'package:easy_scanner/app/data/models/barcode_timestamp_model.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  // Instance of GetStorage
  final GetStorage _storage = GetStorage();

  // Private constructor
  StorageService._internal();

  // Singleton instance
  factory StorageService() {
    return _instance;
  }

  /// Initialize GetStorage
  static Future<void> init() async {
    await GetStorage.init();
  }

  /// Save data to storage
  Future<void> addNewBusinessCardData({
    required BusinessCardModel businessCardModel,
  }) async {
    List<BusinessCardModel> businessCardModelList = getBusinessCardList();

    businessCardModelList.add(businessCardModel);

    List<Map<String, dynamic>> dataMap = [];
    for (var item in businessCardModelList) {
      dataMap.add(item.toJson());
    }

    await _storage.write(
      AppStringConstants.businessDataKey,
      jsonEncode(dataMap),
    );
  }

  /// Retrieve data from storage
  List<BusinessCardModel> getBusinessCardList() {
    try {
      final data = _storage.read(AppStringConstants.businessDataKey);

      List<dynamic> listItems = jsonDecode(data);
      List<BusinessCardModel> businessCardList = [];
      for (var item in listItems) {
        businessCardList.add(
          BusinessCardModel.fromJson(item as Map<String, dynamic>),
        );
      }

      print('here inside try');
      return businessCardList;
    } catch (error) {
      print('here inside catch');
      return [];
    }
  }

  Future<void> addNewBarcodeData({
    required Barcode barcode,
  }) async {
    List<Barcode> barcodeList =
        getBarcodeList().map((item) => item.barcode).toList();

    barcodeList.add(barcode);

    List<Map<String, dynamic>> dataMap = [];
    for (var item in barcodeList) {
      dataMap.add(item.toJson());
    }

    await _storage.write(
      AppStringConstants.barcodeDataKey,
      jsonEncode(dataMap),
    );
  }

  List<BarcodeTimeStampModel> getBarcodeList() {
    try {
      final data = _storage.read(AppStringConstants.barcodeDataKey);

      List<dynamic> listItems = jsonDecode(data);

      List<BarcodeTimeStampModel> barcodeList = [];

      for (var item in listItems) {
        final barcode = BarcodeJsonExtension.fromJson(
          item as Map<String, dynamic>,
        );

        final timeStamp = DateTime.parse(item['timeStamp']);

        if (barcode != null) {
          final barcodeTimeStamp = BarcodeTimeStampModel(
            barcode: barcode,
            dateTime: timeStamp,
          );

          barcodeList.add(barcodeTimeStamp);
        }
      }

      return barcodeList;
    } catch (error) {
      return [];
    }
  }

  /// Delete a specific key
  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  /// Clear all data in storage
  Future<void> clear() async {
    await _storage.erase();
  }

  /// Check if a key exists
  bool hasKey(String key) {
    return _storage.hasData(key);
  }
}
