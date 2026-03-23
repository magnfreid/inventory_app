import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class StockListTile extends StatelessWidget {
  const StockListTile({
    required this.stock,
    required this.onPressed,
    super.key,
  });

  final StockPresentation stock;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Row(
        children: [
          Text(stock.storageName),
          const Spacer(),
          Text(
            stock.quantity.toString(),
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
