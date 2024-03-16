import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_app/screens/qr_scanner.dart';

// MobileScannerController controller =
//     MobileScannerController(detectionSpeed: DetectionSpeed.normal, detectionTimeoutMs: 2000, torchEnabled: isFlashOn);
const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

const bgColor = Color(0xfffafafa);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MobileScannerController? controller;
  int _selectedIndex = 0;
  bool isFlashOn = false;
  @override
  void initState() {
    super.initState();
    // Aca se inicializa el controlador para manejar mas que todo el funcionamiento del flash
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 2000,
      torchEnabled: isFlashOn,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const Text('Home', style: optionStyle),
      QRScanner(controller: controller),
      const Text('Settings', style: optionStyle),
    ];
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
              icon: Icon(Icons.flash_on, color: isFlashOn ? Colors.white : Colors.black),
              onPressed: () {
                _toggleFlash();
              })
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: const Color.fromARGB(255, 216, 92, 43),
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(icon: LineIcons.camera, text: 'QR Scanner'),
                  GButton(icon: LineIcons.alternatePen, text: 'Settings'),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (value) => setState(() {
                      _selectedIndex = value;
                      //Si el index seleccionado es 1, se inicializa el controlador para que el flash funcione
                      if (_selectedIndex == 1) {
                        controller = MobileScannerController(
                          detectionSpeed: DetectionSpeed.normal,
                          detectionTimeoutMs: 2000,
                          torchEnabled: isFlashOn,
                        );
                      }
                      //Si el index seleccionado es diferente a 1, se desactiva el flash
                      if (_selectedIndex != 1) {
                        isFlashOn = false;
                      }
                    })),
          ),
        ),
      ),
    );
  }

  //Funcion para activar o desactivar el flash y el pintado
  void _toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      controller?.toggleTorch();
    });
  }
}
