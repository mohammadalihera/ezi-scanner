import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageScannerPage extends StatefulWidget {
  const ImageScannerPage({super.key});

  @override
  State<ImageScannerPage> createState() => _ImageQRScannerStatePage();
}

class _ImageQRScannerStatePage extends State<ImageScannerPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _scanResult;
  bool _isLoading = false;

  Future<void> _pickAndScanImage() async {
    try {
      setState(() {
        _isLoading = true;
        _scanResult = null;
      });

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        setState(() => _isLoading = false);
        return;
      }

      setState(() {
        _image = File(pickedFile.path);
      });

      final MobileScannerController controller = MobileScannerController();

      try {

        controller.analyzeImage(pickedFile.path).then(
              (capture) {
            if (capture?.barcodes.isNotEmpty ?? false) {
              setState(() {
                 Barcode? _barcode =   capture?.barcodes.firstOrNull;
                _scanResult = 'Value: ${_barcode?.rawValue ?? ""}\nFormat: ${_barcode?.format.name ?? ""}\nType: ${_barcode?.type.name ?? ""}';
              });
            } else {
              setState(() {
                _scanResult = 'No QR code or barcode found in the image';
              });
              print("_scanResult 2 $_scanResult");
            }
            controller.dispose();
            setState(() => _isLoading = false);
          },
        );
      } catch (e) {
        print("Error $e");
        setState(() {
          _scanResult = 'Error analyzing image: $e';
          _isLoading = false;
        });
        controller.dispose();
      }
    } catch (e) {
      setState(() {
        _scanResult = 'Error picking image: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Image QR Scanner'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickAndScanImage,
                icon: Icon(Icons.image),
                label: Text('Pick Image to Scan'),
              ),
              const SizedBox(height: 20),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
              if (_image != null) ...[
                const SizedBox(height: 20),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
              if (_scanResult != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scan Result:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(_scanResult!),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
