import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/barcode_scanner_controller.dart';

class BarcodeScannerView extends GetView<BarcodeScannerController> {
  const BarcodeScannerView({super.key});


  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: controller.scanAreaSize,
      height: controller.scanAreaSize,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.scannerType == "qrcode" ? "QR":"Barcode"} Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () async {
              await controller.cameraController.toggleTorch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () async {
              await controller.cameraController.switchCamera();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.handleDetect,
            scanWindow: scanWindow,
            overlayBuilder: (context, constraints) {
              return QRScannerOverlay(scanAreaSize: controller.scanAreaSize);
            },
          ),
        ],
      ),
    );
  }
}


class QRScannerOverlay extends StatelessWidget {
  final double scanAreaSize;

  const QRScannerOverlay({
    super.key,
    required this.scanAreaSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: ScanAreaClipper(scanAreaSize: scanAreaSize),
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(),
            ),
          ),
        ),
        Center(
          child: Container(
            width: scanAreaSize,
            height: scanAreaSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Position the code within the frame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ScanAreaClipper extends CustomClipper<Path> {
  final double scanAreaSize;

  ScanAreaClipper({required this.scanAreaSize});

  @override
  Path getClip(Size size) {
    Rect scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanAreaSize,
      height: scanAreaSize,
    );

    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
        scanRect,
        const Radius.circular(12),
      ))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

