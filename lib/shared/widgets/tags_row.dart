import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class TagsRow extends StatelessWidget {
  const TagsRow({
    required this.part,
    this.textStyle,
    super.key,
  });

  final PartPresentation part;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        if (part.brandTag != null)
          _TagBadge(tag: part.brandTag!, textStyle: textStyle),
        if (part.categoryTag != null)
          _TagBadge(tag: part.categoryTag!, textStyle: textStyle),
      ],
    );
  }
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.tag, this.textStyle});

  final TagPresentation tag;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      mainAxisSize: .min,
      children: [
        Icon(size: 12, Icons.tag, color: tag.color),
        Text(
          tag.label.toUpperCase(),
          style:
              textStyle ??
              context.text.labelSmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
