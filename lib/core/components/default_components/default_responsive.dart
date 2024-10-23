import 'package:flutter/material.dart';

class DefaultResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const DefaultResponsive({
    super.key,
    required this.mobile,
    required this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else if (constraints.maxWidth < 1200) {
          return tablet;
        } else if (constraints.maxWidth < 1800 && desktop != null) {
          return desktop!;
        } else {
          return largeDesktop!;
        }
      },
    );
  }
}
