import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../config/locale/app_localizations_setup.dart';
import '../config/routes/app_routes.dart';
import '../config/themes/app_theme.dart';
import '../core/bloc/global_cubit/locale_cubit.dart';
import '../core/bloc/global_cubit/theme_cubit.dart';
import '../core/utils/app_strings.dart';
import 'service_locator.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black12,
    ));

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LocaleCubit>()..getSavedLang()),
          BlocProvider(create: (context) => sl<ThemeCubit>()..getThemeMode()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, mode) {
            return BlocBuilder<LocaleCubit, LocaleState>(
                buildWhen: (previousState, currentState) {
              return previousState != currentState;
            }, builder: (context, state) {
              return GlobalLoaderOverlay(
                  child: MaterialApp.router(
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                themeMode: mode.themeMode,
                routerConfig: AppRoutes().config(),
                theme: AppTheme.getApplicationLightTheme(),
                darkTheme: AppTheme.getApplicationDarkTheme(),
                locale: state.locale,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
              ));
            });
          },
        ));
  }
}

//./gradlew signingReport