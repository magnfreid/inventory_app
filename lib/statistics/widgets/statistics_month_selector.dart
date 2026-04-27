import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';

/// Month navigation row shown at the top of the statistics screen.
///
/// Displays the current [monthLabel] between previous / next arrow buttons.
/// The forward button is disabled when [canStepForward] is false.
class StatisticsMonthSelector extends StatelessWidget {
  /// Creates a [StatisticsMonthSelector].
  const StatisticsMonthSelector({
    required this.monthLabel,
    required this.canStepForward,
    super.key,
  });

  /// Formatted label for the currently selected month.
  final String monthLabel;

  /// Whether the user can navigate to a later month.
  final bool canStepForward;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: .center,
      children: [
        IconButton(
          tooltip: l10n.statisticsPreviousMonth,
          onPressed: () => context
              .read<StatisticsBloc>()
              .add(const StatisticsMonthStepRequested(-1)),
          icon: const Icon(Icons.chevron_left),
        ),
        const SizedBox(width: 4),
        Text(
          monthLabel,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          tooltip: l10n.statisticsNextMonth,
          onPressed: canStepForward
              ? () => context
                    .read<StatisticsBloc>()
                    .add(const StatisticsMonthStepRequested(1))
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
