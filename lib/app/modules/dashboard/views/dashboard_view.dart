import 'package:easy_scanner/app/modules/home/views/widgets/custome_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    level: 'Scan \n QR Code',
                    onTap: () {},
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    level: 'Scan \n BAR Code',
                    onTap: () {},
                    icon: const Icon(
                      Icons.view_quilt_sharp,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    level: 'Scan \n Business Card',
                    onTap: () {},
                    icon: const Icon(
                      Icons.view_comfortable_outlined,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    level: 'Scan Image',
                    onTap: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  level: 'Generate \n QR Code',
                  onTap: () {},
                  icon: const Icon(
                    Icons.qr_code,
                    color: Colors.blue,
                    size: 50,
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    level: 'History',
                    onTap: () {},
                    icon: const Icon(
                      Icons.history,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
