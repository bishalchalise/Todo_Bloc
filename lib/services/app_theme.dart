import 'package:flutter/material.dart';

enum AppTheme { darkTheme, lightTheme }

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(),
    ),
    AppTheme.lightTheme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(),
    ),
  };
}
