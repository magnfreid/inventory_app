import 'package:flutter/material.dart';

/// Theme related extensions for easier styling through context.
extension ThemeExtension on BuildContext {
  /// Getter for the current text theme.
  TextTheme get text => TextTheme.of(this);

  /// Getter for the current color scheme.
  ColorScheme get colors => ColorScheme.of(this);

  /// Getter for the current theme data
  ThemeData get theme => Theme.of(this);
}
