import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF8FCFF),
    brightness: Brightness.light,
    fontFamily: "Main",
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimaryColor,
      onPrimaryContainer: AppColors.onBackground,
      secondary: AppColors.secondryColor,
      surface: AppColors.onBackground,
      onSurface: AppColors.thirdColor,
      onSurfaceVariant: AppColors.lightSurface,
      onInverseSurface: Colors.white,
      onPrimaryFixed: AppColors.onBackground,
      error: Colors.red,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: AppColors.onPrimaryColor,
        fontSize: 15.sp,
        fontWeight: .w500,
      ),
      titleLarge: TextStyle(
        color: AppColors.thirdColor,
        fontSize: 20.sp,
        fontWeight: .bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: "Main",
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.darkOnPrimary,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkSurface,
      onPrimaryFixed: AppColors.darkSurface,
      onInverseSurface: AppColors.darkSurface,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );
}
