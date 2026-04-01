part of 'statistics_bloc.dart';

/// Events for [StatisticsBloc].
sealed class StatisticsEvent {
  /// Base for statistics events.
  const StatisticsEvent();
}

/// Initial and explicit reload of stats for [StatisticsState.selectedMonth].
final class StatisticsLoadRequested extends StatisticsEvent {
  /// Creates a load request (e.g. first frame or retry).
  const StatisticsLoadRequested();
}

/// User chose a different month to display (year + month; day is ignored).
final class StatisticsMonthChanged extends StatisticsEvent {
  /// Creates an event with the calendar month to show.
  const StatisticsMonthChanged(this.month);

  /// Any [DateTime] in the target month; normalized to month start in the bloc.
  final DateTime month;
}

/// Move [StatisticsState.selectedMonth] by one month (e.g. arrow buttons).
///
/// Positive [delta] is later; the bloc does not move past the current month.
final class StatisticsMonthStepRequested extends StatisticsEvent {
  /// Creates a step event; typically [delta] is `-1` or `1`.
  const StatisticsMonthStepRequested(this.delta);

  /// Months to add to the current selection (see [DateTime] month arithmetic).
  final int delta;
}
