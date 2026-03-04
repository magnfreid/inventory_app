import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/inventory/widgets/inventory_stock_bottom_sheet.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/tags/models/tag_ui_model.dart';

class InventoryPartCard extends StatelessWidget {
  const InventoryPartCard({
    required this.part,
    super.key,
  });

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, PartDetailsPage.route(item: part)),
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
                          Row(
                            spacing: 4,
                            children: [
                              if (part.brandTag != null)
                                _TagBadge(tag: part.brandTag!),
                              if (part.categoryTag != null)
                                _TagBadge(tag: part.categoryTag!),
                            ],
                          ),
                          Text(
                            part.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            part.detailNumber,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        part.totalQuantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.3,
                  ),
                  Wrap(
                    children: part.stock
                        .where((stock) => stock.quantity > 0)
                        .map(
                          (stock) => Card.outlined(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            child: Padding(
                              padding: const .all(3),
                              child: Text(
                                '${stock.storageName.toUpperCase()}'
                                ' (${stock.quantity})',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                ),
                              ),
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

class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.tag});

  final TagUiModel tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(vertical: 1, horizontal: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: tag.color,
          width: 0.75,
        ),
        borderRadius: .circular(4),
      ),
      child: Text(
        tag.label,
        style: TextStyle(fontSize: 10, color: tag.color),
      ),
    );
  }
}
