import 'dart:io';
import 'package:easy_scanner/app/data/models/businesss_card_model.dart';
import 'package:easy_scanner/app/data/models/job_roles.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class OcrService {
  /// Extracts text from the provided image file
  static Future<String> performOcr(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      await textRecognizer.close();
      return recognizedText.text; // Complete text extracted from the image
    } catch (e) {
      debugPrint('Error during OCR: $e');
      return 'Failed to extract text.';
    }
  }

  /// Parse raw text to extract business card fields
  static BusinessCardModel parseText(String text) {
    final lines = text.split('\n');
    final contact = BusinessCardModel();

    // Regular expressions for parsing
    final nameRegex = RegExp(r'^([a-zA-Z]+(?:[\s\.]?[a-zA-Z]+)*)$');

    final phoneRegex = RegExp(r'\+?[0-9\s\-]{7,}');
    final emailRegex =
    RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
    final websiteRegex = RegExp(r'https?://[^\s]+|www\.[^\s]+');
    final companyRegex = RegExp(r'^[A-Z][a-zA-Z\s]+$');
    final addressRegex = RegExp(r'\d{1,5}\s\w+');

    int index = 0;
    for (var line in lines) {
      if (index == 0) {
        print(line);
      }
      index++;

      if (contact.phone == null && phoneRegex.hasMatch(line)) {
        contact.phone = phoneRegex.firstMatch(line)?.group(0)?.trim();
      } else if (contact.email == null && emailRegex.hasMatch(line)) {
        contact.email = emailRegex.firstMatch(line)?.group(0)?.trim();
      } else if (contact.website == null && websiteRegex.hasMatch(line)) {
        contact.website = websiteRegex.firstMatch(line)?.group(0)?.trim();
      } else if (contact.name == null && line.contains(nameRegex)) {
        contact.name = line.trim();
      } else if (contact.company == null &&
          line.contains(companyRegex) &&
          !(JobRoles.designationKeywords
              .any((keyword) => line.contains(keyword)))) {
        contact.company = line.trim();
      } else if (contact.address == null && line.contains(addressRegex)) {
        contact.address = line.trim();
      }
    }

    return contact;
  }
}
