import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get text => TextTheme.of(this);
}
