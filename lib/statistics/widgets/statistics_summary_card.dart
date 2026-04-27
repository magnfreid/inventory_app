import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// A single metric card shown in the summary row of the statistics screen.
///
/// Displays a coloured icon container, a large [value] string, and a [label].
class StatisticsSummaryCard extends StatelessWidget {
  /// Creates a [StatisticsSummaryCard].
  const StatisticsSummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  /// Icon drawn inside the coloured container.
  final IconData icon;

  /// Short descriptive label shown below the value.
  final String label;

  /// Formatted metric value.
  final String value;

  /// Accent colour used for the icon container and value text.
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.text;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: context.colors.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
