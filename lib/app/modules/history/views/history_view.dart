import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/extensions/date_extensions.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgetElements.commonAppBar(title: 'History', back: true),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, int i) {
            return Container(
              decoration: CustomWidgetElements.commonDecorationWithShadow(),
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: CustomWidgetElements.commonDecoration(
                      color: Color(0xfff4f4f4),
                    ),
                    child: const Center(
                      child: Icon(Icons.wifi),
                    ),
                  ),
                  horizontal12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wifi Credentials',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Description and details ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      vertical4,
                      Text(
                        DateTime.now().toFormatDDMMYYYY(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (_, int i) {
            return vertical12;
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
