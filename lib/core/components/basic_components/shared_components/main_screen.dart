import 'package:admin/config/routes/app_routes.dart';
import 'package:admin/core/components/default_components/default_responsive_layout.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';
import '../mobile_components/mobile_home_layout.dart';
import '../desktop_components/desktop_home_layout.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Map<String, dynamic>> _screens = [
    {
      "icon": Icons.dashboard,
      "iconBorder": Icons.dashboard_outlined,
      "title": AppStrings.shopping,
      "route": Routes.dashboardRoute
    },
    {
      "icon": Icons.category,
      "iconBorder": Icons.category_outlined,
      "title": AppStrings.cart,
      "route": Routes.categoriessRoute,
    },
    {
      "icon": Icons.list,
      "iconBorder": Icons.favorite_border,
      "title": AppStrings.favourite,
      "route": Routes.productsRoute,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultResponsiveLayout(
        mobile: MobileHomeLayout(screens: _screens),
        tablet: MobileHomeLayout(
          screens: _screens,
        ),
        largeFullMobile: MobileHomeLayout(
          screens: _screens,
        ),
        desktop: const DesktopHomeLayout(),
        largeDesktop: const DesktopHomeLayout(),
        largeTablet: const DesktopHomeLayout(),
      ),
    );
  }
}
