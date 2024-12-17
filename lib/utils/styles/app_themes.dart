import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData girlTheme = ThemeData(
    primarySwatch: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
  );

  static ThemeData boyTheme = ThemeData(
    primarySwatch: AppColors.secondaryColor,
    primaryColor: AppColors.secondaryColor,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
  );
}
