import 'package:flutter/material.dart';
import 'package:myapp/src/screens/splash_screen.dart';
import 'package:myapp/src/theme/app_theme.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4118448816.
        theme: AppTheme.lightTheme,
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1717431702.
        home: const SplashScreen());
  }
}
