import 'package:flutter/material.dart';
import 'package:tag_repository/tag_repository.dart';

extension TagColorX on TagColor {
  Color toColor() => switch (this) {
    .red => Colors.red,
    .crimson => Colors.red.shade800,
    .orange => Colors.orange,
    .deepOrange => Colors.deepOrange,
    .amber => Colors.amber,
    .yellow => Colors.yellow,
    .lime => Colors.lime,
    .green => Colors.green,
    .lightGreen => Colors.lightGreen,
    .emerald => Colors.green.shade700,
    .blue => Colors.blue,
    .lightBlue => Colors.lightBlue,
    .indigo => Colors.indigo,
    .navy => Colors.blue.shade900,
    .cyan => Colors.cyan,
    .teal => Colors.teal,
    .purple => Colors.purple,
    .deepPurple => Colors.deepPurple,
    .violet => Colors.deepPurple.shade300,
    .pink => Colors.pink,
    .rose => Colors.pink.shade300,
  };

  static TagColor fromColor(Color color) => TagColor.values.firstWhere(
    (tag) => tag.toColor() == color,
    orElse: () => TagColor.blue,
  );
}
