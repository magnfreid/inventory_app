import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';
import 'package:inventory_app/statistics/widgets/statistics_leaderboard.dart';
import 'package:inventory_app/statistics/widgets/statistics_month_selector.dart';
import 'package:inventory_app/statistics/widgets/statistics_summary_card.dart';
import 'package:inventory_app/statistics/widgets/statistics_transaction_tile.dart';
import 'package:stock_repository/stock_repository.dart';

/// Statistics feature entry: provides the bloc and hosts the view.
class StatisticsPage extends StatelessWidget {
  /// Creates a page that wires repositories into [StatisticsBloc].
  const StatisticsPage({super.key});

  /// [MaterialPageRoute] for the drawer and other callers.
  static MaterialPageRoute<void> route() =>
      MaterialPageRoute<void>(builder: (context) => const StatisticsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.drawerStatisticsLinkText)),
      body: BlocProvider(
        create: (_) => StatisticsBloc(
          stockRepository: context.read<StockRepository>(),
        ),
        child: const StatisticsView(),
      ),
    );
  }
}

/// Statistics screen body: reacts to [StatisticsBloc] state and renders
/// summary metrics, a contributor leaderboard, and the transaction list.
class StatisticsView extends StatelessWidget {
  /// Creates the statistics UI subtree (expects a [StatisticsBloc] above).
  const StatisticsView({super.key});

  bool _canStepForward(DateTime selected) {
    final now = DateTime.now();
    return !DateTime(selected.year, selected.month + 1)
        .isAfter(DateTime(now.year, now.month));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        if (state.status == StatisticsStatus.error) {
          return Center(child: Text(state.error.toString()));
        }
        if (state.status == StatisticsStatus.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final l10n = context.l10n;
        final stats = state.stats;
        final decimalFormat = NumberFormat('#,##0.00');

        return SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: StatisticsMonthSelector(
                    monthLabel: DateFormat.yMMMM().format(state.selectedMonth),
                    canStepForward: _canStepForward(state.selectedMonth),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: .stretch,
                      children: [
                        Expanded(
                          child: StatisticsSummaryCard(
                            icon: Icons.arrow_downward_rounded,
                            label: l10n.statisticsIncoming,
                            value: stats.totalIncoming.toString(),
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: StatisticsSummaryCard(
                            icon: Icons.arrow_upward_rounded,
                            label: l10n.statisticsOutgoing,
                            value: stats.totalOutgoing.toString(),
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: StatisticsSummaryCard(
                            icon: Icons.recycling,
                            label: l10n.statisticsRecycledSavings,
                            value: decimalFormat.format(stats.recycledSavings),
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (stats.topContributors.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: StatisticsLeaderboard(
                      contributors: stats.topContributors,
                    ),
                  ),
                ),
              if (stats.items.isEmpty)
                SliverFillRemaining(
                  child: Center(child: Text(l10n.statisticsNoTransactions)),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  sliver: SliverList.builder(
                    itemCount: stats.items.length,
                    itemBuilder: (context, index) =>
                        StatisticsTransactionTile(item: stats.items[index]),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
