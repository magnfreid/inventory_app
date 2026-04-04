import 'package:flutter/material.dart';

enum AppSeedColor {
  blueGrey,
  teal,
  deepPurple,
  orange,
  green;

  Color get color {
    switch (this) {
      case AppSeedColor.blueGrey:
        return Colors.blueGrey;
      case AppSeedColor.teal:
        return Colors.teal;
      case AppSeedColor.deepPurple:
        return Colors.deepPurple;
      case AppSeedColor.orange:
        return Colors.orange;
      case AppSeedColor.green:
        return Colors.green;
    }
  }
}
