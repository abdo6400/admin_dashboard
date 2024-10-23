import 'package:flutter/material.dart';

extension AppSizes on BuildContext {
  // Screen height and width as getters
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  // Margins, padding, size, font, and radius as getters
  double get marginHeight => screenHeight * 0.01;
  double get paddingHeight => screenHeight * 0.01;
  double get sizeHeight => screenHeight * 0.01;
  double get marginWidth => screenWidth * 0.01;
  double get paddingWidth => screenWidth * 0.01;
  double get sizeWidth => screenWidth * 0.01;

  // Font size based on screen width as a getter
  double get font {
    if (screenWidth < 600) {
      return 16.0; // Mobile device: base font size
    } else if (screenWidth >= 600 && screenWidth < 1024) {
      return 18.0; // Tablet: slightly larger font size
    } else {
      return 20.0; // Desktop: larger font size
    }
  }

  // Radius as a getter
  double get radius => screenWidth * 0.02;
}

extension ResponsiveLayout on BuildContext {
  // Device size as a getter
  Size get deviceSize => MediaQuery.of(this).size;

  // Mobile, tablet, and desktop check as getters
  bool get isMobile => deviceSize.width < 600;
  bool get isTablet => deviceSize.width >= 600 && deviceSize.width < 1024;
  bool get isDesktop => deviceSize.width >= 1024;

  // Get responsive width and height as getters
  double responsiveWidth(double percentage) => deviceSize.width * percentage;
  double responsiveHeight(double percentage) => deviceSize.height * percentage;
}
