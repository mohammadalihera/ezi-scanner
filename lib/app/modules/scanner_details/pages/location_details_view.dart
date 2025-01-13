import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as b_w;

import 'package:get/get.dart';

class LocationDetailsView extends StatelessWidget {
  final String url;
  final b_w.BarcodeWidget barcode;
  const LocationDetailsView({
    super.key,
    required this.barcode,
    required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.size.width,
            decoration: CustomWidgetElements.commonDecorationWithShadow(),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BarcodeView(barcode: barcode),
                vertical20,
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 25),
                    horizontal4,
                    Text(
                      'Location',
                      style: AppTextStyles.h4Bold,
                    ),
                  ],
                ),
                vertical4,
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SelectableText(
                    url,
                    style: AppTextStyles.h4.copyWith(color: Colors.blue),
                    textAlign: TextAlign.start,
                  ),
                ),
                vertical12,
                Text(DateTime.now().toFormatDDMMYYYY()),
                vertical20,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidgetElements.copyButton(url),
                    vertical12,
                    CustomWidgetElements.mapButton(context, url),
                    vertical12,
                    CustomWidgetElements.shareButton(url),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
