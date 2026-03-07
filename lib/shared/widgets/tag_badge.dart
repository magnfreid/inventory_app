import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';

class TagBadge extends StatelessWidget {
  const TagBadge({required this.tag, super.key});

  final TagPresentation tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      mainAxisSize: .min,
      children: [
        Icon(size: 12, Icons.tag, color: tag.color),
        Text(
          tag.label.toUpperCase(),
          style: context.text.labelSmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
