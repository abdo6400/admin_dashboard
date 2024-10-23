import 'package:flutter/material.dart';

class DefaultResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget largeFullMobile; // New widget for large full mobile
  final Widget tablet;
  final Widget largeTablet; // New widget for large tablet
  final Widget desktop;
  final Widget largeDesktop;

  const DefaultResponsiveLayout({
    super.key,
    required this.mobile,
    required this.largeFullMobile, // Add new constructor parameter
    required this.tablet,
    required this.largeTablet, // Add new constructor parameter
    required this.desktop,
    required this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get screen width

    // Define custom breakpoints
    if (width < 480) {
      // Standard mobile
      return mobile;
    } else if (width >= 480 && width < 600) {
      // Large full mobile
      return largeFullMobile;
    } else if (width >= 600 && width < 840) {
      // Standard tablet
      return tablet;
    } else if (width >= 840 && width < 1024) {
      // Large tablet
      return largeTablet;
    } else if (width >= 1024 && width < 1440) {
      // Standard desktop
      return desktop;
    } else {
      // Large desktop
      return largeDesktop;
    }
  }
}
