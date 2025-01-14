import 'package:barcode_widget/barcode_widget.dart' as b_w;
import 'package:easy_scanner/app/core/constants/app_colors.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/utils/app_utils.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:screenshot/screenshot.dart';

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
    if (controller.barcodeList.value.isEmpty) {
      return SizedBox.shrink();
    }
    return ListView.separated(
      key: ValueKey(controller.currentTab.value),
      itemCount: controller.barcodeList.value.length,
      itemBuilder: (context, index) {
        return _barcodeListItem(controller.barcodeList.value[index]);
      },
      separatorBuilder: (_, index) {
        return vertical12;
      },
    );
  }

  _businessCardList() {
    return ListView.builder(
      key: ValueKey(controller.currentTab.value),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item ${index + 1}'),
        );
      },
    );
  }

  Widget _barcodeListItem(Barcode barcode) {
    return Container(
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
    );
  }
}
