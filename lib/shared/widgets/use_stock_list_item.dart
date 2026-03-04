import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:inventory_app/l10n/l10n.dart';

class UseStockListItem extends StatelessWidget {
  const UseStockListItem({
    required this.stock,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final StockPresentation stock;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              stock.storageName,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 60,
                ),
                child: Card.filled(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Center(
                      child: Text(
                        stock.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: AppButton(
                width: .wrap,
                isLoading: isLoading,
                onPressed: onPressed,
                label: l10n.useButtonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
