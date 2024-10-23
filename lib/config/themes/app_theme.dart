import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import 'widgets_theme/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData getApplicationLightTheme() {
    return FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
            appBarScrolledUnderElevation: 10,
            appBarBackgroundSchemeColor: SchemeColor.tertiaryContainer),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        useMaterial3ErrorColors: true,
        tertiaryContainer: AppColors.white,
        scaffoldBackground: AppColors.nearlyWhite,
        fontFamily: 'Cairo',
        primary: AppColors.primary,
        appBarStyle: FlexAppBarStyle.scaffoldBackground,
        textTheme: AppTextTheme.lightTextTheme());
  }

  static ThemeData getApplicationDarkTheme() {
    return FlexThemeData.dark(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
            appBarScrolledUnderElevation: 10,
            appBarBackgroundSchemeColor: SchemeColor.tertiaryContainer),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        useMaterial3ErrorColors: true,
        scaffoldBackground: AppColors.nearlyBlack,
        tertiaryContainer: AppColors.black,
        primary: AppColors.primary,
        fontFamily: 'Cairo',
        appBarStyle: FlexAppBarStyle.scaffoldBackground,
        textTheme: AppTextTheme.darkTextTheme());
  }
}
