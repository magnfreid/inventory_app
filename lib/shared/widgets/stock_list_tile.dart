import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class StockListTile extends StatelessWidget {
  const StockListTile({
    required this.stock,
    required this.part,
    required this.onPressed,
    super.key,
  });

  final StockPresentation stock;
  final PartPresentation part;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      title: Row(
        children: [
          Text(stock.storageName),
          const Spacer(),
          Text(stock.quantity.toString()),
        ],
      ),
      trailing: AppButton.text(
        onPressed: onPressed,
        label: l10n.inStockUseButtonLabelText,
      ),
    );
  }
}
