import 'package:flutter/material.dart';
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
      surface: AppColors.thirdColor,
      surfaceBright: AppColors.fourthColor,
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
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.light,
    fontFamily: "Main",
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimaryColor,
      onPrimaryContainer: AppColors.onBackground,
      secondary: AppColors.secondryColor,
      surface: AppColors.thirdColor,
      surfaceBright: AppColors.fourthColor,
      error: Colors.red,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: AppColors.onPrimaryColor,
        fontSize: 15.sp,
        fontWeight: .w500,
      ),
      titleLarge: TextStyle(
        color: AppColors.fourthColor,
        fontSize: 20.sp,
        fontWeight: .bold,
      ),
    ),
  );
}