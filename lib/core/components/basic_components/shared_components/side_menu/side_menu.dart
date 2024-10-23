import 'package:flutter/material.dart';
import 'side_menu_item.dart';
import 'side_menu_options.dart';
import 'side_menu_item_widget.dart';
import 'side_menu_style.dart';
import 'side_menu_toggle_button.dart';

class SideMenu extends StatefulWidget {
  final String? image;
  final IconData? icon;
  final String? title;
  final List<SideMenuItem> items;
  final Widget? footer;
  final SideMenuStyle? style;
  final ValueChanged<String>? onPageChanged;
  final String initialRoute;
  late final SideMenuOptions options;

  SideMenu({
    super.key,
    required this.items,
    required this.style,
    required this.initialRoute,
    this.onPageChanged,
    this.image,
    this.icon,
    this.footer,
    this.title,
  }) : assert((image != null || icon != null),
            "you must provide either image or icon") {
    options = SideMenuOptions(initialRoute: initialRoute);
    options.onPageChanged = onPageChanged;
  }

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return MouseRegion(
      onEnter: (value) =>
          widget.options.hoverMenuModeState.change(SideMenuDisplayMode.open),
      onExit: (value) =>
          widget.options.hoverMenuModeState.change(SideMenuDisplayMode.compact),
      child: Container(
        padding: EdgeInsetsDirectional.only(end: size.width * 0.02),
        height: size.height,
        child: ValueListenableBuilder(
          valueListenable: widget.options.hoverMenuModeState,
          builder: (context, hovered, child) {
            return ValueListenableBuilder(
              valueListenable: widget.options.displayModeState,
              builder: (context, value, child) => Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: _toggleDuration(),
                    width: _calculateWidth(value, hovered, size),
                    height: size.height,
                    decoration: _decoration(value, widget.style),
                    child: Column(
                      children: [
                        _buildAppBarContent(value, hovered, size, context),
                        SizedBox(height: size.height * 0.04),
                        _buildMenuItemsList(value, hovered, size),
                        if (widget.footer != null) widget.footer!,
                      ],
                    ),
                  ),
                  _buildToggleButton(value, hovered, context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBarContent(SideMenuDisplayMode value,
      SideMenuDisplayMode hovered, Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 5,
        left: size.width * 0.012,
        right: size.width * 0.012,
      ),
      alignment: AlignmentDirectional.center,
      height: AppBar().preferredSize.height + 5,
      child: (value == SideMenuDisplayMode.open ||
              hovered == SideMenuDisplayMode.open)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.image != null)
                  FittedBox(
                    fit: BoxFit.fill,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.image!),
                      radius: size.width * 0.02,
                    ),
                  ),
                if (widget.icon != null) Icon(widget.icon),
                const Expanded(flex: 1, child: SizedBox()),
                if (widget.title != null)
                  Expanded(
                    flex: 8,
                    child: Text(
                      widget.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: widget.style?.titleStyle ??
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: size.width * 0.02,
                              ),
                    ),
                  )
              ],
            )
          : _buildAvatarOrIcon(size),
    );
  }

  Widget _buildAvatarOrIcon(Size size) {
    if (widget.image != null) {
      return FittedBox(
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.image!),
          radius: size.width * 0.02,
        ),
      );
    } else if (widget.icon != null) {
      return Icon(widget.icon);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMenuItemsList(
      SideMenuDisplayMode value, SideMenuDisplayMode hovered, Size size) {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.items.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: size.height * 0.02),
        itemBuilder: (context, index) => SizedBox(
          width: _calculateWidth(value, hovered, size),
          child: SideMenuItemWidget(
            sideMenuItem: widget.items[index],
            sideMenuOptions: widget.options,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(SideMenuDisplayMode value,
      SideMenuDisplayMode hovered, BuildContext context) {
    return (widget.style?.showToggle ?? false) &&
            (hovered == SideMenuDisplayMode.open ||
                value == SideMenuDisplayMode.open)
        ? Positioned.directional(
            textDirection: Directionality.of(context),
            top: 15,
            end: -20,
            child: SideMenuToggle(
              mode: value,
              onTap: () => widget.options.displayModeState.change(
                value == SideMenuDisplayMode.open
                    ? SideMenuDisplayMode.compact
                    : SideMenuDisplayMode.open,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  double _calculateWidth(
      SideMenuDisplayMode mode, SideMenuDisplayMode hovered, Size size) {
    double compactWidth;
    double openWidth;

    if (size.width >= 1440) {
      compactWidth = size.width * 0.06;
      openWidth = size.width * 0.16;
    } else if (size.width >= 1024) {
      compactWidth = size.width * 0.07;
      openWidth = size.width * 0.18;
    } else if (size.width >= 768) {
      compactWidth = size.width * 0.08;
      openWidth = size.width * 0.25;
    } else {
      compactWidth = size.width * 0.1;
      openWidth = size.width * 0.3;
    }

    if (widget.style != null) {
      compactWidth = widget.style!.compactSideMenuWidth ?? compactWidth;
      openWidth = (widget.style!.openSideMenuWidth != null &&
              widget.style!.openSideMenuWidth! >= compactWidth)
          ? widget.style!.openSideMenuWidth!
          : openWidth;
    }
    if (hovered == SideMenuDisplayMode.compact ||
        mode == SideMenuDisplayMode.compact) {
          widget.options.expandedNotifier.clear();
        }
    return hovered == SideMenuDisplayMode.open &&
            mode == SideMenuDisplayMode.compact
        ? openWidth
        : (mode == SideMenuDisplayMode.open ? openWidth : compactWidth);
  }

  Duration _toggleDuration() {
    return widget.style?.displayModeToggleDuration ??
        const Duration(milliseconds: 200);
  }

  Decoration _decoration(SideMenuDisplayMode mode, SideMenuStyle? menuStyle) {
    final defaultDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      border: Border(
        left: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        right: BorderSide(color: Theme.of(context).dividerColor, width: 1),
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    );
    return mode == SideMenuDisplayMode.open
        ? (widget.style?.openSideMenuDecoration ?? defaultDecoration)
        : (widget.style?.compactSideMenuDecoration ?? defaultDecoration);
  }
}
