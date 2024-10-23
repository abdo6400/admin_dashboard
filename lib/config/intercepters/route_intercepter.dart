import 'package:flutter/material.dart';
import '../../core/utils/custom_print.dart';

class RouteIntercepter extends RouteObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    CustomPrint.printRoute('\x1B[34m[Route Pushed]\x1B[0m -- ${route.settings.name}, Previous: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    CustomPrint.printRoute('\x1B[31m[Route Popped]\x1B[0m -- ${route.settings.name}, Previous: ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    CustomPrint.printRoute('\x1B[33m[Route Removed]\x1B[0m -- ${route.settings.name}, Previous: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    CustomPrint.printRoute('\x1B[35m[Route Replaced]\x1B[0m -- New: ${newRoute?.settings.name}, Old: ${oldRoute?.settings.name}');
  }
}
