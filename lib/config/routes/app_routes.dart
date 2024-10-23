import 'package:admin/core/components/basic_components/shared_components/main_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class Routes {
  static DefaultRoute initialRoute =
      DefaultRoute(screen: const MainScreen(), name: '/');
  static DefaultRoute dashboardRoute = DefaultRoute(
      icon: const Icon(Icons.dashboard),
      screen: const Center(child: Text("dashboard")),
      name: 'dashboardRoute');
  static DefaultRoute categoriessRoute = DefaultRoute(
      icon: const Icon(Icons.category),
      screen: const Center(child: Text("categories")),
      name: 'categoriessRoute',
      children: [statsCategoriesRoute, addCategoriessRoute]);
  static DefaultRoute productsRoute = DefaultRoute(
      icon: const Icon(Icons.shopping_cart_checkout_sharp),
      screen: const Center(child: Text("products")),
      name: 'productsRoute');

  //children
  static DefaultRoute statsCategoriesRoute = DefaultRoute(
      screen: const Center(child: Text("stats categories")),
      name: 'statsCategoriesRoute');
  static DefaultRoute addCategoriessRoute = DefaultRoute(
      screen: const Center(child: Text("Add categories")),
      name: 'addCategoriessRoute');
}

class DefaultRoute extends PageRouteInfo<dynamic> {
  DefaultRoute(
      {List<PageRouteInfo>? children,
      required this.screen,
      this.icon,
      required String name})
      : super(
          name,
          initialChildren: children,
        ) {
    path = name;
    page = PageInfo(
      name,
      builder: (data) {
        return screen;
      },
    );
  }
  final Widget screen;
  late final PageInfo page;
  late final String path;
  final Widget? icon;
}

class AppRoutes extends RootStackRouter {
  @override
  List<CustomRoute> get routes => [
        CustomRoute(
          initial: true,
          path: Routes.initialRoute.path,
          page: Routes.initialRoute.page,
          keepHistory: false,
          children: [
            CustomRoute(
              path: Routes.dashboardRoute.path,
              page: Routes.dashboardRoute.page,
              initial: true,
              durationInMilliseconds: 0,
              reverseDurationInMilliseconds: 0,
            ),
            CustomRoute(
              path: Routes.statsCategoriesRoute.path,
              page: Routes.statsCategoriesRoute.page,
              reverseDurationInMilliseconds: 0,
              durationInMilliseconds: 0,
            ),
            CustomRoute(
              path: Routes.addCategoriessRoute.path,
              page: Routes.addCategoriessRoute.page,
              reverseDurationInMilliseconds: 0,
              durationInMilliseconds: 0,
            ),
            CustomRoute(
              path: Routes.productsRoute.path,
              page: Routes.productsRoute.page,
              reverseDurationInMilliseconds: 0,
              durationInMilliseconds: 0,
            )
          ],
        ),
      ];
}
