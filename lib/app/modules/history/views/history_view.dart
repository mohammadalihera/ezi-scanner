import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:easy_scanner/app/core/constants/app_colors.dart';
import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/utils/app_utils.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:easy_scanner/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgetElements.commonAppBar(title: 'History', back: true),
      body: Column(
        children: [
          SizedBox(
            width: Get.width,
            child: Obx(() {
              return Row(
                children: [
                  ...List.generate(
                    controller.tabTitle.length,
                    (index) => _tabWidget(
                      title: controller.tabTitle[index],
                      isSelected: controller.currentTab.value == index,
                      index: index,
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: Obx(
              () {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size16,
                      vertical: size16,
                    ),
                    child: controller.currentTab.value == 0
                        ? _barcodeList()
                        : _businessCardList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _tabWidget({
    required String title,
    required bool isSelected,
    required int index,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.onTabChange(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(vertical: size14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue : Colors.white,
                width: size2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isSelected
                  ? AppColors.textPrimaryDark
                  : AppColors.textSecondary.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _barcodeList() {
    if (controller.barcodeTimeStampList.value.isEmpty) {
      return SizedBox.shrink();
    }
    return ListView.separated(
      key: ValueKey(controller.currentTab.value),
      itemCount: controller.barcodeTimeStampList.value.length,
      itemBuilder: (context, index) {
        return _barcodeListItem(
          controller.barcodeTimeStampList.value[index].barcode,
          controller.barcodeTimeStampList.value[index].dateTime,
        );
      },
      separatorBuilder: (_, index) {
        return vertical12;
      },
    );
  }

  _businessCardList() {
    if (controller.businessCardList.value.isEmpty) {
      return SizedBox.shrink();
    }
    return ListView.separated(
      key: ValueKey(controller.currentTab.value),
      itemCount: controller.businessCardList.value.length,
      itemBuilder: (context, index) {
        return _businessCardListItem(controller.businessCardList.value[index]);
      },
      separatorBuilder: (context, index) {
        return vertical12;
      },
    );
  }

  Widget _barcodeListItem(
    Barcode barcode,
    DateTime dateTime,
  ) {
    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.SCANNER_DETAILS,
          arguments: barcode,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(size14),
        decoration: BoxDecoration(
          color: AppColors.neutral0,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: radius12,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: b_w.BarcodeWidget(
                  data: barcode.rawValue ?? '',
                  barcode: b_w.Barcode.fromType(
                    AppUtils.getBarcodeType(barcode.format) ??
                        b_w.BarcodeType.QrCode,
                  ),
                ),
              ),
            ),
            horizontal12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barcode.type.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    AppUtils.getInfoForBarcode(barcode),
                    maxLines: 1,
                  ),
                  vertical4,
                  Text(
                    date,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: Icon(AppUtils.getIconForBarcode(barcode)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _businessCardListItem(BusinessCardModel businessCardModel) {
    final dateTime = DateTime.parse(
        businessCardModel.timeStamp ?? DateTime.now().toIso8601String());
    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.BUSINESS_CARD_DETAILS,
          arguments: businessCardModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(size14),
        decoration: BoxDecoration(
          color: AppColors.neutral0,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: radius12,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 65,
              width: 65,
              child: businessCardModel.imagePath != null
                  ? Image.file(
                      File(businessCardModel.imagePath!),
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.hourglass_empty),
            ),
            horizontal12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${businessCardModel.name ?? 'N/A'}',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Phone: ${businessCardModel.phone ?? 'N/A'}',
                    maxLines: 1,
                    style: AppTextStyles.bodyXSmall.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  if (businessCardModel.email != null)
                    Text(
                      'Email: ${businessCardModel.email ?? 'N/A'}',
                      style: AppTextStyles.bodyXSmall.copyWith(
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  vertical4,
                  Text(
                    date,
                    maxLines: 1,
                    style: AppTextStyles.bodyXSmall
                        .copyWith(color: Colors.black54, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
