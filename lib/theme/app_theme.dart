import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    cardColor: Colors.white,
    scaffoldBackgroundColor: AppColors.background,
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: Colors.white,
      filled: true,
    ),
    textTheme: GoogleFonts.rubikTextTheme().copyWith(
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    cardColor: AppColors.backgroundDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    inputDecorationTheme: InputDecorationThemeData(filled: false),
    textTheme: GoogleFonts.rubikTextTheme().copyWith(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );
}
