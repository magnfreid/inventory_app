import 'package:app_ui/app_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/widgets/inventory_stock_bottom_sheet.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/shared/widgets/tag_badge.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class InventoryPartCard extends StatelessWidget {
  const InventoryPartCard({
    required this.part,
    super.key,
  });

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final stocks = part.stock.where((stock) => stock.quantity > 0)
      ..sorted((a, b) => b.storageName.compareTo(a.storageName));
    return Card(
      child: InkWell(
        onTap: () =>
            Navigator.push(context, PartDetailsPage.route(partId: part.partId)),
        onLongPress: () => showModalBottomSheet<void>(
          showDragHandle: true,
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<InventoryBloc>(),
            child: InventoryStockBottomSheet(part: part),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const .all(8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(part.name),
                          Row(
                            spacing: 6,
                            children: [
                              if (part.brandTag != null)
                                TagBadge(tag: part.brandTag!),
                              if (part.categoryTag != null)
                                TagBadge(tag: part.categoryTag!),
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
                      Text(
                        part.totalQuantity.toString(),
                      ),
                    ],
                  ),

                  Wrap(
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
                  ),
                ],
              ),
            ),
            if (part.isRecycled)
              const Positioned(
                top: 3,
                right: 3,
                child: Icon(
                  size: 16,
                  Icons.eco,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
