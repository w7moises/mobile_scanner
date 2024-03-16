import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_app/screens/home.dart';
import 'package:qr_scanner_app/screens/result_screen.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({
    super.key,
    required this.controller,
  });
  final MobileScannerController? controller;
  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  //bool isScanCompleted = false;
  void closeScreen() {
    //isScanCompleted = false;
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size * 0.9;
    double scanAreaWidth = screenSize.width * 0.7;
    scanAreaWidth = scanAreaWidth > screenSize.width ? screenSize.width : scanAreaWidth;
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
                  widget.controller == null
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                            color: Colors.orangeAccent,
                          ),
                        )
                      : MobileScanner(
                          controller: widget.controller,
                          startDelay: true,
                          onDetect: (capture) {
                            //if (!isScanCompleted) {
                            //isScanCompleted = true;
                            String code = '';
                            final List<Barcode> barcodes = capture.barcodes;
                            if (barcodes.isNotEmpty) {
                              code = barcodes.first.rawValue ?? '';
                            }
                            if (code == '') {
                              //isScanCompleted = false;
                              return;
                            } else {
                              print('Codigo detectado: $code');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ResultScreen(
                                            code: code,
                                          ))));
                            }
                          }
                          //},
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
