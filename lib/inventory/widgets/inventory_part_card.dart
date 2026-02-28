import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/inventory/widgets/inventory_stock_bottom_sheet.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/tags/extensions/tag_color_extensions.dart';

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
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          if (part.mainTag != null)
                            Text(
                              part.mainTag!.label,
                              style: TextStyle(
                                color: part.mainTag!.color.toColor(),
                              ),
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
                              padding: const .all(5),
                              child: Text(
                                '${stock.storageName.toUpperCase()}'
                                ' ${stock.quantity}',
                                style: TextStyle(
                                  fontSize: 12,
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
