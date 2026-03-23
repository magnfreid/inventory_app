import 'package:flutter/material.dart';
import 'package:inventory_app/stock/widgets/in_stock_panel.dart';
import 'package:inventory_app/stock/widgets/use_stock_checkout.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class InventoryUseStock extends StatelessWidget {
  const InventoryUseStock({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) => InStockList.route(
        part: part,
        onStockSelected: (stock) => navigatorKey.currentState?.push(
          StockCheckoutPage.route(stock: stock),
        ),
      ),
    );
  }
}
