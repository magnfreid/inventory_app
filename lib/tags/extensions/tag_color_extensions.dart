import 'package:flutter/material.dart';
import 'package:tag_remote/tag_remote.dart';

extension TagColorX on TagColor {
  Color toColor() => switch (this) {
    .red => Colors.red,
    .blue => Colors.blue,
    .yellow => Colors.yellow,
    .green => Colors.green,
    .white => Colors.white,
    .black => Colors.black,
    .purple => Colors.purple,
    .cyan => Colors.cyanAccent,
  };
}
