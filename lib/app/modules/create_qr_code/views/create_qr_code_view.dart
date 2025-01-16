import 'package:barcode_widget/barcode_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_scanner/app/core/constants/barcode_validators.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/widgets/app_button.dart';
import 'package:easy_scanner/app/core/widgets/barcode_view.dart';
import 'package:easy_scanner/app/core/widgets/cutom_widget_elements.dart';
import 'package:easy_scanner/app/core/widgets/tabs.dart';
import 'package:easy_scanner/app/modules/create_qr_code/views/widgets/generateate_code_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:easy_scanner/app/core/services/generate_qr_barcode_service.dart';
import 'package:easy_scanner/app/modules/create_qr_code/controllers/create_qr_code_controller.dart';

class CreateQrCodeView extends GetView<CreateQrCodeController> {
  const CreateQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgetElements.commonAppBar(
        title: 'Generate',
        back: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(size12),
            decoration: CustomWidgetElements.commonDecorationWithShadow(),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration:
                        CustomWidgetElements.commonDecorationWithShadow(),
                    child: Tabs(
                      selectedTabIdentifier:
                          controller.selectedCreateType.value,
                      tabs: ['Qrcode', 'Barcode']
                          .map((ct) => TabItem(label: ct, identifier: ct))
                          .toList(),
                      onTabChange: (v) {
                        controller.selectedCreateType.value = v;
                        if (v == 'Qrcode') {
                          controller.otherTypes.value = true;
                        } else {
                          controller.otherTypes.value = false;
                        }

                        controller.barcodeData.value = "";
                      },
                    ),
                  ),
                  vertical32,
                  if (!controller.otherTypes.value) ...[
                    _buildBarcodeTypeDropdown(),
                    vertical20,
                    _buildBarcodeDataInput(),
                    vertical20,
                  ] else ...[
                    _buildQrTypeDropdown(),
                    vertical20,
                    _buildDynamicFormFields(),
                    vertical20,
                  ],
                  AppButton(
                    name: controller.otherTypes.value
                        ? 'Generate QR Code'
                        : 'Generate Barcode',
                    onTap: () {
                      if (controller.otherTypes.value) {
                        controller.generateOtherTypeQRCode();
                      } else {
                        controller.generateCode();
                      }
                      FocusScope.of(context).unfocus();
                    },
                    textColor: Colors.white,
                    buttonColor: Colors.blue,
                  ),
                  vertical20,
                  if (controller.barcodeData.value.isNotEmpty) _buildPreview(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBarcodeTypeDropdown() {
    return DropdownButtonFormField2<BarcodeType>(
      value: controller.selectedType.value,
      decoration: const InputDecoration(
        labelText: 'Barcode Type',
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      items: BarcodeType.values.map((type) {
        return DropdownMenuItem<BarcodeType>(
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
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 0),
      ),
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 200,
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        selectedMenuItemBuilder: (context, child) {
          return Container(
            color: Colors.grey.withOpacity(0.3),
            child: child,
          );
        },
      ),
    );
  }

  Widget _buildBarcodeDataInput() {
    return TextFormField(
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
          return 'Length must be between ${controller.specs.value.minLength} and ${controller.specs.value.maxLength} characters. Current length: ${value.length}';
        }
        if (!BarcodeValidator.isValidBarcode(
            value, controller.selectedType.value)) {
          return 'Invalid format. Accepted data: ${controller.specs.value.acceptedData}';
        }
        return null;
      },
    );
  }

  Widget _buildQrTypeDropdown() {
    return DropdownButtonFormField2<String>(
      value: controller.selectedOption.value,
      items: [
        "url",
        "text",
        "contact",
        "email",
        "sms",
        "geo",
        "phone",
        "calender",
        "wifi",
      ]
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          controller.selectedOption.value = value;
          controller.barcodeData.value = "";
        }
      },
      decoration: const InputDecoration(
        labelText: "Select QR Code Type",
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      buttonStyleData: const ButtonStyleData(
        // height: 30,
        padding: EdgeInsets.symmetric(horizontal: 0),
      ),
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 200,
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        selectedMenuItemBuilder: (context, child) {
          return Container(
            color: Colors.grey.withOpacity(0.3),
            child: child,
          );
        },
      ),
    );
  }

  Widget _buildUrlForm() {
    return _buildTextField('url', 'Url');
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        _buildTextField("email", "Enter Email Address"),
        _buildTextField("sub", "Enter Subject"),
        _buildTextField("body", "Enter Body"),
      ],
    );
  }

  Widget _buildWifiForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("ssid", "Enter WiFi Name (SSID)"),
        _buildTextField("password", "Enter Password"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: controller.selectedEncryptionType.value,
            items: [
              DropdownMenuItem(value: "WEP", child: Text("WEP")),
              DropdownMenuItem(value: "WPA/WPA2", child: Text("WPA/WPA2")),
            ],
            onChanged: (value) {
              controller.selectedEncryptionType.value = value ?? 'WEP';
            },
            decoration: InputDecoration(
              labelText: "Select Encryption Type",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Encryption Type cannot be empty'
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicFormFields() {
    switch (controller.selectedOption.value) {
      case "url":
        return _buildUrlForm();
      case "text":
        return _buildTextField("text", "Enter Text");
      case "contact":
        return Column(
          children: [
            _buildTextField("name", "Enter Name"),
            _buildTextField("phone", "Enter Phone Number"),
            _buildTextField("email", "Enter Email"),
          ],
        );
      case "email":
        return _buildEmailForm();
      case "sms":
        return Column(
          children: [
            _buildTextField("phone", "Enter Phone Number"),
            _buildTextField("message", "Enter Message"),
          ],
        );
      case "geo":
        return Column(
          children: [
            _buildTextField("latitude", "Enter Latitude"),
            _buildTextField("longitude", "Enter Longitude"),
          ],
        );
      case "phone":
        return _buildTextField("phone", "Enter Phone Number");
      case "calender":
        return _buildCalendarEventForm();
      case "wifi":
        return _buildWifiForm();
      case "custom":
        return _buildTextField("custom", "Enter Custom Data");
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCalendarEventForm() {
    return Column(
      children: [
        _buildDateTimeField("start", "Select Start Date-Time"),
        vertical12,
        _buildDateTimeField("end", "Select End Date-Time"),
        vertical12,
        _buildTextField("title", "Enter Title"),
        _buildTextField("description", "Enter Description"),
        _buildTextField("location", "Enter Location"),
      ],
    );
  }

  Widget _buildDateTimeField(String key, String label) {
    return GestureDetector(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          TimeOfDay? time = await showTimePicker(
            context: Get.context!,
            initialTime: TimeOfDay.now(),
          );
          if (time != null) {
            final selectedDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            controller.textControllers[key]?.text = selectedDateTime.toString();
          }
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller.textControllers[key],
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? '$label cannot be empty' : null,
        ),
      ),
    );
  }

  Widget _buildTextField(String key, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller.textControllers[key],
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(), // Adds a border around the text field
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue, width: 2.0), // Focused state border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0), // Default state border
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.red, width: 1.5), // Error state border
          ),
        ),
        onChanged: (value) => controller.barcodeData.value = "",
        validator: (value) =>
            value == null || value.isEmpty ? '$label cannot be empty' : null,
      ),
    );
  }

  Widget _buildPreview() {
    return Column(
      children: [
        GeneratedCodeView(
          barcodeWidget: BarcodeWidget(
            barcode: GenerateService()
                .getBarcodeFormat(controller.selectedType.value),
            data: controller.barcodeData.value,
            drawText: true,
            width: 200,
            height: 200,
            errorBuilder: (context, error) =>
                const Center(child: Text("Invalid input")),
          ),
          isBar: controller.selectedType.value != BarcodeType.QrCode,
          onDownload: controller.saveCode,
        ),
        vertical12
      ],
    );
  }
}
