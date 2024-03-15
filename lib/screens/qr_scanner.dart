import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_app/screens/home.dart';
import 'package:qr_scanner_app/screens/result_screen.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner(
      {super.key,
      required bool isFlashOn,
      required MobileScannerController controller});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size * 0.9;
    double scanAreaWidth = screenSize.width * 0.7;
    scanAreaWidth =
        scanAreaWidth > screenSize.width ? screenSize.width : scanAreaWidth;
    final scanAreaSize = Size(scanAreaWidth, scanAreaWidth);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pon el codigo QR en el área',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  )),
              SizedBox(
                height: 10,
              ),
              Text('El escaneo del código QR es automático',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  )),
            ],
          )),
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    startDelay: true,
                    onDetect: (capture) {
                      if (!isScanCompleted) {
                        isScanCompleted = true;
                        String code = '';
                        final List<Barcode> barcodes = capture.barcodes;
                        for (final barcode in barcodes) {
                          code = barcode.rawValue!;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ResultScreen(
                                      closeScreen: closeScreen,
                                      code: code,
                                    ))));
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColor: bgColor,
                    borderColor: Colors.orangeAccent,
                    scanAreaSize: scanAreaSize,
                  ),
                ],
              )),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text("Desarrollado por HipeYopukitre",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
