import 'package:flutter/material.dart';
import 'package:admin/core/components/basic_components/shared_components/side_menu/side_menu_child_item.dart';
import 'side_menu_options.dart';

class SideMenuChildItemWidget extends StatelessWidget {
  final SideMenuChildItem sideMenuItem;
  final SideMenuOptions sideMenuOptions;
  final HoverNotifier hoverState = HoverNotifier(false);
  final String parrentRoute;

  SideMenuChildItemWidget({
    super.key,
    required this.sideMenuItem,
    required this.sideMenuOptions,
    required this.parrentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder(
      valueListenable: sideMenuOptions.expandedNotifier,
      builder: (context, isExpanded, child) {
        return ValueListenableBuilder(
          valueListenable: sideMenuOptions.hoverMenuModeState,
          builder: (context, hover, child) {
            return ValueListenableBuilder(
              valueListenable: sideMenuOptions.displayModeState,
              builder: (context, displayMode, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMenuItem(
                        context, size, displayMode, hover, isExpanded),
                    if (_shouldExpand(displayMode, hover, isExpanded))
                      _buildChildItems(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  bool _shouldExpand(SideMenuDisplayMode displayMode,
      SideMenuDisplayMode hoverMode, List<String> isExpanded) {
    return (displayMode == SideMenuDisplayMode.open ||
            hoverMode == SideMenuDisplayMode.open) &&
        isExpanded.contains(sideMenuItem.route) &&
        sideMenuItem.children != null;
  }

  Widget _buildMenuItem(
      BuildContext context,
      Size size,
      SideMenuDisplayMode displayMode,
      SideMenuDisplayMode hoverMode,
      List<String> isExpanded) {
    return ValueListenableBuilder(
      valueListenable: sideMenuOptions.selectedIndexState,
      builder: (context, page, child) {
        return ValueListenableBuilder(
          valueListenable: hoverState,
          builder: (context, isHovered, child) {
            return MouseRegion(
              key: ValueKey(sideMenuItem.route),
              onEnter: (_) => hoverState.change(true),
              onExit: (_) => hoverState.change(false),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.transparent,
                onTap: () => _handleMenuItemTap(context, displayMode, page),
                mouseCursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.012,
                    vertical: size.height * 0.015,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.008,
                    vertical: size.height * 0.015,
                  ),
                  duration: Durations.short1,
                  key: ValueKey(sideMenuItem.route),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isHovered
                        ? Theme.of(context).hintColor.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: _buildMenuItemContent(context, size, displayMode,
                      hoverMode, page, isHovered, isExpanded),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMenuItemContent(
      BuildContext context,
      Size size,
      SideMenuDisplayMode displayMode,
      SideMenuDisplayMode hoverMode,
      String route,
      bool isHovered,
      List<String> isExpanded) {
    return Row(
      children: [
        _buildRadioButton(context, route),
        if (displayMode == SideMenuDisplayMode.open ||
            hoverMode == SideMenuDisplayMode.open)
          Expanded(flex: 10, child: _buildMenuItemText(route, isHovered)),
        if (displayMode == SideMenuDisplayMode.open ||
            hoverMode == SideMenuDisplayMode.open)
          Expanded(
              flex: 1, child: _buildExpandIcon(context, route, isExpanded)),
      ],
    );
  }

  Widget _buildRadioButton(BuildContext context, String route) {
    return Expanded(
      flex: 2,
      child: FittedBox(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Radio(
            splashRadius: 0,
            fillColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
            value: route == sideMenuItem.route,
            groupValue: true,
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemText(String route, bool isHovered) {
    return Text(
      sideMenuItem.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: isHovered || route == sideMenuItem.route
          ? sideMenuItem.selectedTitleTextStyle
          : sideMenuItem.unselectedTitleTextStyle,
    );
  }

  Widget _buildExpandIcon(
      BuildContext context, String route, List<String> isExpanded) {
    return sideMenuItem.children != null
        ? InkWell(
            onTap: () => _toggleExpand(),
            child: AnimatedRotation(
              turns: isExpanded.contains(sideMenuItem.route) ? 0.25 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 3,
              ),
            ),
          )
        : sideMenuItem.trailing ?? const SizedBox();
  }

  void _handleMenuItemTap(BuildContext context, SideMenuDisplayMode displayMode,
      String route) {
    if (route != sideMenuItem.route) {
      sideMenuItem.onTap?.call();
      sideMenuOptions.onPageChanged?.call(sideMenuItem.route);
      sideMenuOptions.selectedIndexState.change(sideMenuItem.route);
    }
  }

  void _toggleExpand() {
    if (!sideMenuOptions.expandedNotifier.contains(sideMenuItem.route)) {
      sideMenuOptions.expandedNotifier.add(sideMenuItem.route);
    } else {
      sideMenuOptions.expandedNotifier.remove(sideMenuItem.route);
    }
  }

  Widget _buildChildItems() {
    return Column(
      children: sideMenuItem.children!
          .map(
            (e) => SideMenuChildItemWidget(
              sideMenuItem: e,
              parrentRoute: parrentRoute,
              sideMenuOptions: sideMenuOptions,
            ),
          )
          .toList(),
    );
  }
}
