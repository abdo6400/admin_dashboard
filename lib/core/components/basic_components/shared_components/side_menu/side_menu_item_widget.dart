import 'package:flutter/material.dart';
import 'side_menu_child_item_widget.dart';
import 'side_menu_item.dart';
import 'side_menu_options.dart';

class SideMenuItemWidget extends StatelessWidget {
  final SideMenuItem sideMenuItem;
  final SideMenuOptions sideMenuOptions;
  final HoverNotifier hoverState = HoverNotifier(false);

  SideMenuItemWidget({
    super.key,
    required this.sideMenuItem,
    required this.sideMenuOptions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder(
      valueListenable: sideMenuOptions.displayModeState,
      builder: (context, displayMode, child) {
        return ValueListenableBuilder(
          valueListenable: sideMenuOptions.hoverMenuModeState,
          builder: (context, hoverMode, child) {
            return ValueListenableBuilder(
              valueListenable: sideMenuOptions.expandedNotifier,
              builder: (context, isExpanded, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildMenuItem(
                        context, size, displayMode, hoverMode, isExpanded),
                    if (_shouldExpand(displayMode, hoverMode, isExpanded))
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
                highlightColor: Colors.transparent,
                onTap: () =>
                    _handleMenuItemTap(context, displayMode, page, isExpanded),
                mouseCursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildMenuItemContent(context, size, displayMode,
                          hoverMode, page, isHovered, isExpanded),
                    ),
                    _buildIndicator(context, page, isHovered),
                  ],
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
    final isOpen = (displayMode == SideMenuDisplayMode.open ||
        hoverMode == SideMenuDisplayMode.open);

    return AnimatedContainer(
      alignment: isOpen
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.012),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.008, vertical: size.height * 0.015),
      duration: const Duration(milliseconds: 200),
      key: ValueKey(sideMenuItem.route),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _getMenuItemBackgroundColor(context, route, isHovered),
      ),
      child: isOpen
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(fit: BoxFit.fill, child: sideMenuItem.icon),
                if (isOpen)
                  Expanded(child: _buildMenuItemText(route, isHovered)),
              ],
            )
          : FittedBox(
              fit: BoxFit.fill,
              child: sideMenuItem.icon ??
                  Text(sideMenuItem.title,
                      style: _getMenuItemTextStyle(route, isHovered)),
            ),
    );
  }

  Widget _buildMenuItemText(String route, bool isHovered) {
    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 8,
          child: Text(
            sideMenuItem.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getMenuItemTextStyle(route, isHovered),
          ),
        ),
        Expanded(
          flex: 1,
          child: sideMenuItem.children != null
              ? InkWell(
                  onTap: () => _toggleExpand(),
                  child: AnimatedRotation(
                    turns: _isExpanded() ? 0.25 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child:
                        const Icon(Icons.arrow_forward_ios_outlined, size: 20),
                  ),
                )
              : sideMenuItem.trailing ?? const SizedBox(),
        ),
      ],
    );
  }

  bool isSelected(String route) {
    bool isSelected = sideMenuItem.route == route;
    if (sideMenuItem.children!=null && !isSelected) {
      isSelected = sideMenuItem.children!.any((e) => e.route == route);
    }
    return isSelected;
  }

  Color _getMenuItemBackgroundColor(
      BuildContext context, String route, bool isHovered) {
    return isSelected(route)
        ? Theme.of(context).primaryColor.withOpacity(0.3)
        : isHovered
            ? Theme.of(context).hintColor.withOpacity(0.1)
            : Colors.transparent;
  }

  TextStyle? _getMenuItemTextStyle(String route, bool isHovered) {
    return isHovered || isSelected(route)
        ? sideMenuItem.selectedTitleTextStyle
        : sideMenuItem.unselectedTitleTextStyle;
  }

  Widget _buildIndicator(
      BuildContext context, String route, bool isHovered) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected(route)
            ? Theme.of(context).primaryColor.withOpacity(0.3)
            : isHovered
                ? Theme.of(context).hintColor.withOpacity(0.1)
                : Colors.transparent,
      ),
      duration: Durations.extralong1,
      height: 45,
      width: 4,
    );
  }

  Widget _buildChildItems() {
    return Column(
      children: sideMenuItem.children!
          .map((e) => SideMenuChildItemWidget(
                sideMenuItem: e,
                parrentRoute: sideMenuItem.route,
                sideMenuOptions: sideMenuOptions,
              ))
          .toList(),
    );
  }

  void _handleMenuItemTap(BuildContext context, SideMenuDisplayMode displayMode,
      String route, List<String> isExpanded) {
    if (route != sideMenuItem.route) {
      sideMenuItem.onTap?.call();
    }
    if (sideMenuItem.children == null || sideMenuItem.children!.isEmpty) {
      sideMenuOptions.expandedNotifier.clear();
      sideMenuOptions.onPageChanged?.call(sideMenuItem.route);
      sideMenuOptions.selectedIndexState.change(sideMenuItem.route);
    }else{
      _toggleExpand();
    }
  }

  void _toggleExpand() {
    if (!sideMenuOptions.expandedNotifier.contains(sideMenuItem.route)) {
      sideMenuOptions.expandedNotifier.add(sideMenuItem.route);
    } else {
      sideMenuOptions.expandedNotifier.remove(sideMenuItem.route);
    }
  }

  bool _isExpanded() {
    return sideMenuOptions.expandedNotifier.contains(sideMenuItem.route);
  }
}
