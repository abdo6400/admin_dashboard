
import 'package:flutter/material.dart';
import 'side_menu_child_item.dart';

class SideMenuItem {
  final Function? onTap;
  final String title;
  final String  route;
  final Widget? icon;
  final Widget? trailing;
  final List<SideMenuChildItem>? children;
  final TextStyle? selectedTitleTextStyle;
  final TextStyle? unselectedTitleTextStyle;

  SideMenuItem({
    required this.title,
     this.icon,
    required this.route,
    this.onTap,
    this.trailing,
    this.children,
    this.selectedTitleTextStyle,
    this.unselectedTitleTextStyle,
  });
}
