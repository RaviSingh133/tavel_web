import 'package:flutter/material.dart';
import '../../Theme/image_string.dart';

class BackgroundLayout extends StatelessWidget {
  final Widget child; // <-- Page content goes here

  const BackgroundLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Images
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  top: 300,
                  left: 0,
                  child: Image.asset(
                    RImages.cir1,
                    width: 1000,
                    height: 1800,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -400,
                  top: 10,
                  child: Image.asset(
                    RImages.cir5,
                    width: 900,
                    height: 1600,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 400,
                  right: 0,
                  left: -50,
                  top: 0,
                  child: Image.asset(
                    RImages.cir6,
                    width: 900,
                    height: 1600,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          // 🔹 Main Scrollable Content
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
