import 'package:flutter/material.dart';

class AppColors {
  //* Main Colors
  static const Color primary = Color(0xff696bff);
  static const Color secondary = Color(0xff696bEE);

  //* Greyscale Colors
  static const Color darkGrey = Color(0xff525252);
  static const Color grey = Color(0xff999999);
  static const Color lightGrey = Color.fromRGBO(223, 223, 223, 1);

  //* Black & White Colors
  static const Color black  = Color(0xff2b2c40);
  static const Color nearlyBlack = Color(0xff232333);
  static const Color white = Color(0xffffffff);
  static const Color nearlyWhite = Color.fromRGBO(245, 245, 250,1);

  //* Additional Colors
  static const Color error = Color(0xffe61f34); // Red color
  static const Color hintColor = Color(0xFF707070);
  static const Color blueLight = Color.fromRGBO(35, 79, 104, 1);
  static const Color greenDark = Color(0xff45a247);
  static const Color green = Color.fromRGBO(0, 217, 95, 1);

  static Color hexToColor(String hexString) {
    hexString = hexString.replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }

    return Color(int.parse(hexString, radix: 16));
  }
}
