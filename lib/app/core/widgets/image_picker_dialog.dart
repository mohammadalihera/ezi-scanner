import 'dart:io';

import 'package:easy_scanner/app/core/constants/app_colors.dart';
import 'package:easy_scanner/app/core/constants/enums.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:easy_scanner/app/core/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog._({super.key});

  static Future<File?> show({
    bool barrierDismissible = true,
  }) async {
    final pickerType = await Get.dialog(
      const ImagePickerDialog._(),
      barrierDismissible: barrierDismissible,
    );

    if (pickerType == ImagePickerType.gallery) {
      return await ImagePickerService.pickImageFromGallery();
    } else if (pickerType == ImagePickerType.camera) {
      return await ImagePickerService.pickImageFromCamera();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(size20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Image Source',
              style: TextStyle(
                fontSize: size20,
                color: AppColors.textPrimaryColor,
              ),
            ),
            vertical40,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _pickerButton(
                  context: context,
                  title: 'Gallery',
                  icon: Icons.photo,
                  imagePickerType: ImagePickerType.gallery,
                ),
                horizontal20,
                _pickerButton(
                  context: context,
                  title: 'Camera',
                  icon: Icons.camera_alt,
                  imagePickerType: ImagePickerType.camera,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickerButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required ImagePickerType imagePickerType,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.back(result: imagePickerType);
        },
        child: Container(
          padding: const EdgeInsets.all(size20),
          decoration: BoxDecoration(
              color: AppColors.secondary100,
              borderRadius: radius16,
              border: Border.all(color: AppColors.secondary500)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40),
              vertical8,
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
