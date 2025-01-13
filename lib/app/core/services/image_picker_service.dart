import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

abstract class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  /// Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  /// Pick image from camera

  static Future<File?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static Future<String?> cropImage({
    // required BuildContext context,
    required File pickedFile,
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        // WebUiSettings(
        //   context: context,
        //   presentStyle: WebPresentStyle.dialog,
        //   size: const CropperSize(
        //     width: 520,
        //     height: 520,
        //   ),
        // ),
      ],
    );
    if (croppedFile != null) {
      return croppedFile.path;
    }
    return null;
  }

  static Future<void> saveImage({
    required File imageFile,
    required String fileName,
  }) async {
    if (await Permission.storage.request().isGranted ||
        await Permission.photos.request().isGranted) {
      try {
        // Get default storage path
        String storagePath = await getDefaultStoragePath();

        // Ensure the directory exists
        final directory = Directory(storagePath);
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        // Save the file
        final filePath = '$storagePath/$fileName';
        final savedImage = await imageFile.copy(filePath);

        await refreshGallery(savedImage.path);
        Get.snackbar('Success', 'Check your gallery or files.');
      } catch (e) {
        Get.snackbar('Failed', 'Download failed. Please try again');
      }
    } else {
      Get.snackbar('Failed', 'permission denied');
    }
  }

  static Future<String> getDefaultStoragePath() async {
    Directory? directory;

    if (Platform.isAndroid) {
      // Get the external storage directory
      directory = await getExternalStorageDirectory();

      // Navigate to the Downloads folder or other directories
      final downloadsPath = '${directory!.path.split('Android')[0]}Download';
      return downloadsPath;
    } else if (Platform.isIOS) {
      // For iOS, use the documents directory
      directory = await getApplicationDocumentsDirectory();
    }

    return directory!.path;
  }

// Refresh the gallery to make the image visible
  static Future<void> refreshGallery(String filePath) async {
    try {
      final result = await Process.run('am', [
        'broadcast',
        '-a',
        'android.intent.action.MEDIA_SCANNER_SCAN_FILE',
        '-d',
        'file://$filePath'
      ]);
    } catch (e) {}
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
