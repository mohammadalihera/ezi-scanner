import 'dart:io';
import 'package:easy_scanner/app/core/services/image_picker_service.dart';
import 'package:easy_scanner/app/core/services/ocr_service.dart';
import 'package:easy_scanner/app/core/services/storage_service.dart';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:get/get.dart';
import 'package:easy_scanner/app/core/widgets/image_picker_dialog.dart';

class BusinessCardDetailsController extends GetxController {
  Rx<String?> imagePath = Rx(null);
  Rx<BusinessCardModel?> businessCardModel = Rx(null);
  Rx<bool> inProgress = false.obs;

  String get imageFileValue => imagePath.value!;

  @override
  void onReady() async {
    businessCardModel.value = Get.arguments;

    imagePath.value = businessCardModel.value?.imagePath;

    if (businessCardModel.value == null) {
      await pickImageAndScanText();
    }
    super.onReady();
  }

  pickImageAndScanText() async {
    inProgress.value = true;
    final file = await ImagePickerDialog.show();

    if (file != null) {
      final croppedFilePath = await ImagePickerService.cropImage(
        pickedFile: file,
      );

      if (croppedFilePath != null) {
        imagePath.value = croppedFilePath;
        final obtainedText = await OcrService.performOcr(File(croppedFilePath));
        businessCardModel.value = OcrService.parseText(obtainedText);
        businessCardModel.value!.imagePath =
            await ImagePickerService.saveImageToAppDirectory(
          File(croppedFilePath),
        );

        StorageService().addNewBusinessCardData(
          businessCardModel: businessCardModel.value!,
        );
      }
    }
    inProgress.value = false;
  }

  void saveCardImage() async {
    await ImagePickerService.saveImage(
        imageFile: File(imagePath.value!),
        fileName: imagePath.value!.split('/').last);
  }
}
