import 'package:flutter/material.dart';

class SideMenuStyle {
  final double? openSideMenuWidth;
  final double? compactSideMenuWidth;
  final Decoration? openSideMenuDecoration;
  final Decoration? compactSideMenuDecoration;
  final TextStyle? titleStyle;
  final bool? showToggle;
  final bool? alwaysShowFooter;
  final Duration? displayModeToggleDuration;

  SideMenuStyle({
    this.showToggle = true,
    this.alwaysShowFooter = false,
    this.titleStyle,
    this.openSideMenuDecoration,
    this.compactSideMenuDecoration,
    this.displayModeToggleDuration,
    this.openSideMenuWidth,
    this.compactSideMenuWidth,
  });
}
