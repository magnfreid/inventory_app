import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';
import 'package:stock_remote/stock_remote.dart';

/// A single row in the statistics transaction list.
///
/// Shows the transaction type icon, part name, storage, user, timestamp,
/// and signed amount. Optionally renders the note if present.
class StatisticsTransactionTile extends StatelessWidget {
  /// Creates a [StatisticsTransactionTile].
  const StatisticsTransactionTile({required this.item, super.key});

  /// The transaction data to display.
  final TransactionListItem item;

  static final DateFormat _dateFormat = DateFormat.MMMd().add_Hm();

  @override
  Widget build(BuildContext context) {
    final tx = item.transaction;
    final l10n = context.l10n;
    final isIncoming = tx.amount > 0;
    final sign = isIncoming ? '+' : '';
    final amountText = '$sign${tx.amount}';
    final (typeIcon, typeColor) = _iconAndColor(tx.type, isIncoming);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: context.colors.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(typeIcon, color: typeColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Text(
                          item.partName,
                          style: context.text.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        amountText,
                        style: context.text.bodyMedium?.copyWith(
                          color: typeColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${tx.detailNumber} · ${tx.storageName}',
                    style: context.text.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${tx.userDisplayName} · '
                          '${_dateFormat.format(tx.timestamp)}',
                          style: context.text.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (tx.note != null && tx.note!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.notes,
                          size: 13,
                          color: context.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${l10n.statisticsMessageLabel}: ${tx.note}',
                            style: context.text.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 2,
                            overflow: .ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Maps [TransactionType] to an icon and accent colour.
  (IconData, Color) _iconAndColor(TransactionType type, bool isIncoming) =>
      switch (type) {
        TransactionType.use => (Icons.arrow_upward, Colors.deepOrange),
        TransactionType.restock => (Icons.arrow_downward, Colors.green),
        TransactionType.transfer => (Icons.swap_horiz, Colors.blue),
        TransactionType.adjustment => isIncoming
            ? (Icons.add_circle_outline, Colors.green)
            : (Icons.remove_circle_outline, Colors.deepOrange),
      };
}
