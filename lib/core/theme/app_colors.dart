import 'package:flutter/material.dart';

abstract class AppColors {
  // Light Mode Colors
  static const Color primaryColor = Color(0xff01B7F1);
  static const Color onPrimaryColor = Color(0xffA1A1A1);
  static const Color onBackground = Color(0xffEDFBFF);
  static Color secondryColor = const Color(0xff005773).withValues(alpha: .56);
  static const Color secondryColorText = Color(0xff1B6180);
  static const Color onSecondryColor = Color(0xff6CD0F7);
  static const Color onSecondryContainer = Color(0xffE4FAFF);
  static const Color thirdColor = Colors.black;
  static const Color onThirdColor = Color(0xff1b1c1f);
  static const Color lightSurface = Color(
    0xFFF0F9FF,
  ); // Soft light blue instead of white

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF0F172A); // Very dark navy blue
  static const Color darkSurface = Color(0xFF1E293B); // Navy surface
  static const Color darkOnPrimary = Color(0xFFF1F5F9);
  static const Color darkSecondary = Color(0xFF0EA5E9);
  static const Color darkOnSecondary = Color(0xff6CD0F7);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate blue-grey
}
