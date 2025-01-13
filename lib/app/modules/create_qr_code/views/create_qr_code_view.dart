import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/services/generate_qr_barcode_service.dart';
import 'package:easy_scanner/app/modules/create_qr_code/controllers/create_qr_code_controller.dart';
import 'package:easy_scanner/app/modules/create_qr_code/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateQrCodeView extends GetView<CreateQrCodeController> {
  const CreateQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr and Barcode Generator'),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(
              Icons.filter_list_outlined,
            ),
          )
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<BarcodeType>(
                  value: controller.selectedType.value,
                  decoration: const InputDecoration(
                    labelText: 'Barcode Type',
                    border: OutlineInputBorder(),
                  ),
                  items: BarcodeType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(GenerateService().getBarcodeTypeName(type)),
                    );
                  }).toList(),
                  onChanged: (BarcodeType? value) {
                    if (value != null) {
                      controller.selectedType.value = value;
                      controller.barcodeData.value = "";
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  focusNode: controller.focusNode,
                  controller: controller.barcodeController,
                  decoration: const InputDecoration(
                    labelText: 'Enter barcode data',
                    border: OutlineInputBorder(),
                    errorMaxLines: 5,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter barcode data';
                    }

                    if (value.length < controller.specs.value.minLength ||
                        value.length > controller.specs.value.maxLength) {
                      return 'Length must be between ${controller.specs.value.minLength} and ${controller.specs.value.maxLength} characters\nCurrent length: ${value.length}';
                    }

                    if (!BarcodeValidator.isValidBarcode(
                        value, controller.selectedType.value)) {
                      return 'Invalid format. Accepted data: ${controller.specs.value.acceptedData}';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.generateCode,
                  child: const Text('Generate Barcode'),
                ),
                const SizedBox(height: 24),
                if (controller.barcodeData.value != "") ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BarcodeWidget(
                      barcode: GenerateService()
                          .getBarcodeFormat(controller.selectedType.value),
                      data: controller.barcodeData.value,
                      drawText: true,
                      width: 200,
                      height: 200,
                      errorBuilder: (context, error) {
                        return const Center(
                          child: Text("Invalid input"),
                        );
                      },
                    ),
                  ),
                  vertical20,
                  ElevatedButton(
                    onPressed: controller.saveCode,
                    child: const Icon(Icons.save),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
