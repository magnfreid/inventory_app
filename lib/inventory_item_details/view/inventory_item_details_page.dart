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
      body: Column(
        children: [
          ListTile(title: const Text('Name'), subtitle: Text(item.name)),
          ListTile(
            title: const Text('Detail number'),
            subtitle: Text(item.detailNumber),
          ),
          ListTile(
            title: const Text('Price'),
            subtitle: Text(item.price.toString()),
          ),
        ],
      ),
    );
  }
}
