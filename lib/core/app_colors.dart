import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xffc1e024);
  static const Color secondary = Color.fromARGB(255, 233, 241, 194);
  static const Color accent = Color(0xff64c991);
  static const Color accent2 = Color(0xff3ee6e9);
  static const Color text = Color(0xff151322);
}

class AppTheme {
  static ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              backgroundColor: MaterialStatePropertyAll(AppColors.primary),
              foregroundColor: MaterialStatePropertyAll(AppColors.text))));
}
