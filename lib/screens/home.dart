import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_scanner_app/screens/qr_scanner.dart';

int _selectedIndex = 0;
bool isFlashOn = false;
const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
final List<Widget> _widgetOptions = <Widget>[
  const Text('Home', style: optionStyle),
  QRScanner(isFlashOn: isFlashOn),
  const Text('Settings', style: optionStyle),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const bgColor = Color(0xfffafafa);

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on,
                color: isFlashOn ? Colors.white : Colors.black),
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
          ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(icon: LineIcons.home, text: 'Home'),
                  GButton(icon: LineIcons.camera, text: 'QR Scanner'),
                  GButton(icon: LineIcons.alternatePen, text: 'Settings'),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (value) => setState(() {
                      _selectedIndex = value;
                    })),
          ),
        ),
      ),
    );
  }
}
