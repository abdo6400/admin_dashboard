import 'package:admin/config/locale/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../bloc/global_cubit/locale_cubit.dart';
import '../../../bloc/global_cubit/theme_cubit.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../shared_components/side_menu/side_menu_widget.dart';

class DesktopHomeLayout extends StatelessWidget {
  const DesktopHomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    final routes = [
      Routes.dashboardRoute,
      Routes.categoriessRoute,
      Routes.productsRoute
    ];
    return Row(
      children: [
        SideMenu(
          image: AppImages.appLogo,
          title: AppStrings.appName.tr(context),
          initialRoute: context.router.currentPath.allAfter("/"),
          onPageChanged: (String path) {
            context.router.pushNamed(path);
          },
          style: SideMenuStyle(
            showToggle: true,
          ),
          items: routes
              .map(
                (e) => SideMenuItem(
                  route: e.path,
                  icon: e.icon,
                  title: e.page.name.toString(),
                  children: e.hasChildren
                      ? [
                          ...e.initialChildren?.map(
                                (child) => SideMenuChildItem(
                                    route: (child as DefaultRoute).path,
                                    title: (child).page.name),
                              ) ??
                              []
                        ]
                      : null,
                ),
              )
              .toList(),
        ),
        Expanded(
          child: Scaffold(
            body: Stack(
              children: [
                const AutoRouter(),
                Positioned.directional(
                  top: 10,
                  start: 0,
                  end: 10,
                  textDirection: Directionality.of(context),
                  child: Card(
                    surfaceTintColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    shadowColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(children: [
                        Switch(
                          value: context.watch<ThemeCubit>().currentThemeMode ==
                              ThemeMode.dark,
                          onChanged: (value) {
                            if (value) {
                              context.read<ThemeCubit>().toDarkMode();
                            } else {
                              context.read<ThemeCubit>().toLightMode();
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            if (context.read<LocaleCubit>().currentLangCode ==
                                "ar") {
                              context.read<LocaleCubit>().toEnglish();
                            } else {
                              context.read<LocaleCubit>().toArabic();
                            }
                          },
                          icon: CircleAvatar(
                            child: Text(context
                                .watch<LocaleCubit>()
                                .currentLangCode
                                .toUpperCase()),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      //),
    );
  }
}
