import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';

class AppTextTheme {
  static TextTheme lightTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal, color: AppColors.black),
      displayMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.black),
      displaySmall: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.black),
      headlineLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.black),
      headlineMedium: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.black),
      headlineSmall: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.black),
      titleLarge: TextStyle(
          fontSize: 21, fontWeight: FontWeight.w500, color: AppColors.black),
      titleMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),
      titleSmall: TextStyle(fontSize: 16, color: AppColors.black),
      bodyLarge: TextStyle(fontSize: 14, color: AppColors.black),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkGrey),
      bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),
      labelMedium: TextStyle(fontSize: 12, color: Colors.grey),
      labelSmall: TextStyle(fontSize: 10, color: Colors.grey),
    );
  }

  static TextTheme darkTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal, color: AppColors.white),
      displayMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.white),
      displaySmall: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.white),
      headlineLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white),
      headlineMedium: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white),
      headlineSmall: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
      titleLarge: TextStyle(
          fontSize: 21, fontWeight: FontWeight.w500, color: AppColors.white),
      titleMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white),
      titleSmall: TextStyle(fontSize: 16, color: AppColors.white),
      bodyLarge: TextStyle(fontSize: 14, color: AppColors.white),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightGrey),
      bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white),
      labelMedium: TextStyle(fontSize: 12, color: Colors.grey),
      labelSmall: TextStyle(fontSize: 10, color: Colors.grey),
    );
  }
}
