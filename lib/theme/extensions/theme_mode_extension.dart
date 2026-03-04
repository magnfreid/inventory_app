import 'package:flutter/material.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';

extension AppThemeModeX on AppThemeMode {
  ThemeMode toThemeMode() {
    if (this == .light) return .light;
    if (this == .dark) return .dark;
    return .system;
  }
}
