import 'package:flutter/material.dart';

///Theme related extensions for easier styling through context
extension TextThemeExtension on BuildContext {
  ///Getter for the current text theme
  TextTheme get text => TextTheme.of(this);
}
