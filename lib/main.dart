import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_app/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 243, 189, 164),
              elevation: 0)),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
