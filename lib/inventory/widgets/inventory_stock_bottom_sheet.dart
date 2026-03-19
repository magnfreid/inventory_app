import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/shared/widgets/stock_list_tile.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class InventoryStockBottomSheet extends StatelessWidget {
  const InventoryStockBottomSheet({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryBloc, InventoryState>(
      listenWhen: (previous, current) =>
          previous.bottomSheetStatus != current.bottomSheetStatus &&
          current.bottomSheetStatus == .done,
      listener: (context, state) => Navigator.of(context).pop(),
      child: BlocBuilder<InventoryBloc, InventoryState>(
        buildWhen: (previous, current) =>
            previous.bottomSheetStatus != current.bottomSheetStatus,
        builder: (context, state) {
          final stocks = part.stock
              .where((stock) => stock.quantity > 0)
              .toList();
          return SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const .fromLTRB(8, 0, 0, 10),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          part.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          part.detailNumber,
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: stocks.length,
                      itemBuilder: (context, index) {
                        final stock = stocks[index];
                        return StockListTile(
                          stock: stock,
                          part: part,
                          onPressed: () => context.read<InventoryBloc>().add(
                            UseStockButtonPressed(
                              partId: part.partId,
                              storageId: stock.storageId,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
