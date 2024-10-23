
import 'package:flutter/widgets.dart';


class SideMenuOptions {
  DisplayModeNotifier displayModeState =
      DisplayModeNotifier(SideMenuDisplayMode.compact);
  HoverMenuModeNotifier hoverMenuModeState =
      HoverMenuModeNotifier(SideMenuDisplayMode.compact);
  late SelectedRouteNotifier selectedIndexState;
  HoverNotifier isHoveredState = HoverNotifier(false);
  ValueChanged<String>? onPageChanged;
  final ExpandedNotifier expandedNotifier = ExpandedNotifier([]);
  SideMenuOptions({required String initialRoute}) {
    selectedIndexState = SelectedRouteNotifier(initialRoute);
  }
}

class HoverMenuModeNotifier extends ValueNotifier<SideMenuDisplayMode> {
  HoverMenuModeNotifier(super.value);

  void change(SideMenuDisplayMode mode) {
    if (value != mode) {
      value = mode;
      notifyListeners();
    }
  }
}

class DisplayModeNotifier extends ValueNotifier<SideMenuDisplayMode> {
  DisplayModeNotifier(super.value);

  void change(SideMenuDisplayMode mode) {
    if (value != mode) {
      value = mode;
      notifyListeners();
    }
  }
}

class SelectedRouteNotifier extends ValueNotifier<String> {
  SelectedRouteNotifier(super.value);

  void change(String route) {
    if (value != route) {
      value = route;
      notifyListeners();
    }
  }
}

class HoverNotifier extends ValueNotifier<bool> {
  HoverNotifier(super.value);

  void change(bool isHovered) {
    if (value != isHovered) {
      value = isHovered;
      notifyListeners();
    }
  }
}

class ExpandedNotifier extends ValueNotifier<List<String>> {
  ExpandedNotifier(super.value);

  bool contains(String route) {
    return value.contains(route);
  }

  void add(String route) {
    value.add(route);
    notifyListeners();
  }

  void remove(String route) {
    value.remove(route);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }
}

enum SideMenuDisplayMode { open, compact }
