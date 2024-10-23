
import 'package:flutter/material.dart';

class SideMenuChildItem {
  final Function? onTap;
  final String title;
  final String  route;
  final Widget? trailing;
  final List<SideMenuChildItem>? children;
  final TextStyle? selectedTitleTextStyle;
  final TextStyle? unselectedTitleTextStyle;

  SideMenuChildItem({
    required this.title,
    required this.route,
    this.onTap,
    this.trailing,
    this.children,
    this.selectedTitleTextStyle,
    this.unselectedTitleTextStyle,
  });
}
