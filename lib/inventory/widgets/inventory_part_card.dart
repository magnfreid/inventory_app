import 'package:app_ui/app_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/shared/widgets/recycled_icon.dart';
import 'package:inventory_app/shared/widgets/tags_row.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class InventoryPartCard extends StatelessWidget {
  const InventoryPartCard({
    required this.part,
    super.key,
  });

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final stocks = part.stock.where((stock) => stock.quantity > 0).toList()
      ..sorted((a, b) => b.storageName.compareTo(a.storageName));
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, PartDetailsPage.route(part: part)),
        child: Stack(
          children: [
            Padding(
              padding: const .all(8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            spacing: 2,
                            children: [
                              Text(part.name),
                              if (part.isRecycled) const RecycledIcon(),
                            ],
                          ),
                          Text(
                            part.detailNumber,
                            style: context.text.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      TagsRow(part: part),
                    ],
                  ),
                  const Padding(
                    padding: .symmetric(vertical: 2),
                    child: Divider(
                      thickness: 0.3,
                      height: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(child: _InStockBadges(stocks: stocks)),
                      Padding(
                        padding: const .symmetric(vertical: 2, horizontal: 4),
                        child: Text(
                          part.totalQuantity.toString(),
                          style: context.text.bodyMedium?.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InStockBadges extends StatelessWidget {
  const _InStockBadges({
    required this.stocks,
  });

  final List<StockPresentation> stocks;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return stocks.isEmpty
        ? Text(
            l10n.notInStock,
            style: context.text.labelSmall?.copyWith(
              fontStyle: .italic,
              fontWeight: .w300,
            ),
          )
        : Wrap(
            children: stocks
                .map(
                  (stock) => Padding(
                    padding: const .all(3),
                    child: Row(
                      spacing: 8,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          stock.storageName,
                          style: context.text.labelSmall,
                        ),
                        Text(
                          '${stock.quantity}',
                          style: context.text.labelSmall?.copyWith(
                            color: Colors.blueAccent,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
  }
}
