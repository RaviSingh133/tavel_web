import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'image_string.dart';

class FontSizes {
  static const small = 12.0;
  static const standard = 14.0;
  static const standardUp = 16.0;
  static const medium = 20.0;
  static const large = 28.0;
}

class Space {
  static double defaultPadding = 18.0;
  static double iconSpace = 10;
}

class DefaultColors {
  static const Color greyText = Color(0xffb3b9c9);
  static const Color whiteText = Color(0xffffffff);
  static const Color queryButtonColor = Color(0xff3A5A49);
  static const Color numberColor = Color(0xff99d98c);
  static const Color queryColor = Color(0xffD9D73B);
  static const Color appbarButtonColor = Color(0xffD9D73B);
  static const Color aboutHeadingColor = Color(0xff3A5A49);

}

class AppTheme {
  static ThemeData get RTheme {
    return ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        titleMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.medium,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.large,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standard,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: Colors.black,
        ),
      ),
    );
  }
}

