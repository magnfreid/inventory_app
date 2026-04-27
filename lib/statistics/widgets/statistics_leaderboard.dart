import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';

/// Leaderboard section showing the top contributors for the selected month.
///
/// Ranks up to 3 users by transaction count. The user with the highest
/// recycled savings also receives a "Top saver" badge.
class StatisticsLeaderboard extends StatelessWidget {
  /// Creates a [StatisticsLeaderboard].
  const StatisticsLeaderboard({
    required this.contributors,
    super.key,
  });

  /// Ranked list of user activity (at most 3 entries, sorted by
  /// transaction count descending).
  final List<UserActivity> contributors;

  static const _rankColors = [
    Color(0xFFFFD700), // gold
    Color(0xFFC0C0C0), // silver
    Color(0xFFCD7F32), // bronze
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (contributors.isEmpty) return const SizedBox.shrink();

    final topSaverIndex = _topSaverIndex();
    final decimalFormat = NumberFormat('#,##0.00');

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            l10n.statisticsTopContributors,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: context.colors.surfaceContainerHigh,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contributors.length,
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 56),
            itemBuilder: (context, index) {
              final user = contributors[index];
              final rankColor = _rankColors[index];
              final isTopSaver =
                  topSaverIndex == index && user.recycledSavings > 0;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: rankColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: context.text.labelLarge?.copyWith(
                            color: rankColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  user.userDisplayName,
                                  style: context.text.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: .ellipsis,
                                ),
                              ),
                              if (isTopSaver) ...[
                                const SizedBox(width: 6),
                                _TopSaverBadge(
                                  savings: decimalFormat
                                      .format(user.recycledSavings),
                                  label: l10n.statisticsTopSaver,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.statisticsTransactionCount(
                              user.transactionCount,
                            ),
                            style: context.text.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Returns the index of the contributor with the highest recycled savings,
  /// or -1 if none have any savings.
  int _topSaverIndex() {
    var best = -1;
    var bestSavings = 0.0;
    for (var i = 0; i < contributors.length; i++) {
      if (contributors[i].recycledSavings > bestSavings) {
        bestSavings = contributors[i].recycledSavings;
        best = i;
      }
    }
    return best;
  }
}

class _TopSaverBadge extends StatelessWidget {
  const _TopSaverBadge({required this.savings, required this.label});

  final String savings;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(Icons.recycling, size: 12, color: Colors.teal[400]),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.teal[400],
            ),
          ),
        ],
      ),
    );
  }
}
