import 'package:app_ui/app_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/widgets/inventory_stock_bottom_sheet.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/shared/widgets/tag_badge.dart';
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
        onTap: () =>
            Navigator.push(context, PartDetailsPage.route(partId: part.partId)),
        onLongPress: () => _showStockBottomSheet(context),
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
                              if (part.isRecycled)
                                const Icon(
                                  Icons.eco,
                                  color: Colors.green,
                                  size: 16,
                                ),
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
                      _Tags(part: part),
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
            // if (part.isRecycled) const _EcoIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> _showStockBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<InventoryBloc>(),
        child: InventoryStockBottomSheet(part: part),
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
    return stocks.isEmpty
        ? Text(
            'Ej i lager',
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

// class _EcoIndicator extends StatelessWidget {
//   const _EcoIndicator();

//   @override
//   Widget build(BuildContext context) {
//     return const Positioned(
//       top: 3,
//       right: 3,
//       child: Icon(
//         size: 16,
//         Icons.eco,
//         color: Colors.green,
//       ),
//     );
//   }
// }

class _Tags extends StatelessWidget {
  const _Tags({required this.part});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        if (part.brandTag != null) TagBadge(tag: part.brandTag!),
        if (part.categoryTag != null) TagBadge(tag: part.categoryTag!),
      ],
    );
  }
}
