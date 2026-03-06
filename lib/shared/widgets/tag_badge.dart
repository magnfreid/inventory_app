import 'package:flutter/material.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';

class TagBadge extends StatelessWidget {
  const TagBadge({required this.tag, super.key, this.fontSize = 10});

  final TagPresentation tag;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(
        vertical: fontSize <= 10 ? 1 : 2,
        horizontal: fontSize <= 10 ? 2 : 6,
      ),
      decoration: BoxDecoration(
        color: tag.color.withAlpha(20),
        border: Border.all(
          color: tag.color,
          width: 0.75,
        ),
        borderRadius: .circular(2),
      ),
      child: Text(
        tag.label,
        style: TextStyle(fontSize: fontSize, color: tag.color),
      ),
    );
  }
}
