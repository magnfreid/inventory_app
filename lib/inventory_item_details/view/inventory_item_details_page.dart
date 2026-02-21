import 'package:flutter/material.dart';
import 'package:inventory_app/inventory/models/inventory_item_ui_model.dart';

class InventoryItemDetailsPage extends StatelessWidget {
  const InventoryItemDetailsPage({required this.item, super.key});

  final InventoryItemUiModel item;

  static MaterialPageRoute<void> route({
    required InventoryItemUiModel item,
  }) => MaterialPageRoute<void>(
    builder: (context) => InventoryItemDetailsPage(
      item: item,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Placeholder(
        child: Center(
          child: Text('Details of: ${item.name}'),
        ),
      ),
    );
  }
}
