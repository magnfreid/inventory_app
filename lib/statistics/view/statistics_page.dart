import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';
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
    final l10n = context.l10n;
    final stockRepository = context.read<StockRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.drawerStatisticsLinkText),
      ),
      body: BlocProvider(
        create: (_) => StatisticsBloc(
          stockRepository: stockRepository,
        ),
        child: const StatisticsView(),
      ),
    );
  }
}

/// Statistics screen body: reacts to [StatisticsBloc] state and renders metrics
///  and list.
class StatisticsView extends StatelessWidget {
  /// Creates the statistics UI subtree (expects a [StatisticsBloc] above this
  /// widget).
  const StatisticsView({super.key});

  /// Whether stepping one month forward from [selected] stays at or before
  /// the current calendar month.
  bool _canStepForward(DateTime selected) {
    final now = DateTime.now();
    final latest = DateTime(now.year, now.month);
    final next = DateTime(selected.year, selected.month + 1);
    return !next.isAfter(latest);
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

        final stats = state.stats;
        final monthLabel = DateFormat.yMMMM().format(state.selectedMonth);
        final decimalFormat = NumberFormat('#,##0.00');

        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Previous month',
                      onPressed: () => context.read<StatisticsBloc>().add(
                            const StatisticsMonthStepRequested(-1),
                          ),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: Text(
                        monthLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Next month',
                      onPressed: _canStepForward(state.selectedMonth)
                          ? () => context.read<StatisticsBloc>().add(
                                const StatisticsMonthStepRequested(1),
                              )
                          : null,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _MetricCard(
                      label: 'Incoming',
                      value: stats.totalIncoming.toString(),
                      color: Colors.green,
                    ),
                    _MetricCard(
                      label: 'Outgoing',
                      value: stats.totalOutgoing.toString(),
                      color: Colors.orange,
                    ),
                    _MetricCard(
                      label: 'Recycled savings',
                      value: decimalFormat.format(stats.recycledSavings),
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: stats.items.isEmpty
                      ? const Center(
                          child: Text('No transactions for this month'),
                        )
                      : ListView.builder(
                          itemCount: stats.items.length,
                          itemBuilder: (context, index) {
                            final item = stats.items[index];
                            final tx = item.transaction;
                            final isIncoming = tx.amount > 0;
                            final sign = isIncoming ? '+' : '';
                            final amountText = '$sign${tx.amount}';
                            final amountColor =
                                isIncoming ? Colors.green : Colors.orange;
                            final whenStr = DateFormat.yMd()
                                .add_Hm()
                                .format(tx.timestamp);

                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Icon(
                                    isIncoming
                                        ? Icons.south_west
                                        : Icons.north_east,
                                    size: 18,
                                  ),
                                ),
                                title: Text(item.partName),
                                subtitle: Text(
                                  '${tx.detailNumber}\n'
                                  '$whenStr · ${tx.storageName}\n'
                                  '${tx.userDisplayName}\n'
                                  'Message: ${tx.note ?? '-'}',
                                ),
                                isThreeLine: true,
                                trailing: Text(
                                  amountText,
                                  style: TextStyle(
                                    color: amountColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 140),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
