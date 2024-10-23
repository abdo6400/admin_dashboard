import 'package:flutter/material.dart';

import 'side_menu_options.dart';

class SideMenuToggle extends StatelessWidget {
  final Function? onTap;
  final SideMenuDisplayMode mode;

  const SideMenuToggle({
    super.key,
    required this.onTap,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      radius: 20,
      child: InkWell(
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Theme.of(context).primaryColor,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: child.key == const ValueKey('Sidemenu_icon1')
                  ? Tween<double>(begin: 1, end: 0.5).animate(anim)
                  : Tween<double>(begin: 0.5, end: 1).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: mode == SideMenuDisplayMode.open
                ? const Icon(
                    Icons.navigate_next,
                    key: ValueKey('Sidemenu_icon1'),
                    size: 20,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.navigate_next,
                    key: ValueKey('Sidemenu_icon2'),
                    size: 20,
                    color: Colors.white,
                  ),
          ),
        ),
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
      ),
    );
  }
}
