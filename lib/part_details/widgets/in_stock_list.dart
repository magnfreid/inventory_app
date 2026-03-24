import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class InStockList extends StatelessWidget {
  const InStockList({
    required this.part,
    required this.onStockSelected,
    this.textStyle,
    super.key,
  });

  final PartPresentation part;
  final TextStyle? textStyle;
  final void Function(StockPresentation stock) onStockSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stock = part.stock.where((s) => s.quantity > 0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              '${l10n.formFieldInStockLabelText}:',
              style: const TextStyle(fontWeight: .bold),
            ),
            Text(
              '${part.totalQuantity} st',
              style: const TextStyle(fontWeight: .bold),
            ),
          ],
        ),
        const Divider(),
        ListView.separated(
          padding: const .symmetric(vertical: 0, horizontal: 4),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stock.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final items = part.stock.where((s) => s.quantity > 0).toList();
            final stockItem = items[index];

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stockItem.storageName,
                  style: textStyle,
                ),
                Row(
                  children: [
                    Text(
                      stockItem.quantity.toString(),
                      style: textStyle,
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => onStockSelected(stockItem),
                      child: Text(l10n.useButtonText),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
