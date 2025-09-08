import 'package:flutter/material.dart';
import 'package:travel_application/landing_page/landing_page.dart';

import 'Theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPS',
      theme: AppTheme.RTheme,
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
