import 'package:flutter/material.dart';

class AppThemes {
  // Dark theme
  static ThemeData darkTheme(BuildContext context) {
    // final colorScheme = ColorScheme.fromSeed(
    //   seedColor: Colors.black,
    //   brightness: Brightness.dark,
    // );

    const colorScheme = ColorScheme.dark();

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.inversePrimary,
      ),
    );
  }

  // Light theme (placeholder for future)
  static ThemeData lightTheme(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
      ),
    );
  }
}
