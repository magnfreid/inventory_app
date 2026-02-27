import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';

import 'package:inventory_app/shared/widgets/use_stock_list_item.dart';

class InventoryStockBottomSheet extends StatelessWidget {
  const InventoryStockBottomSheet({required this.part, super.key});

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryBloc, InventoryState>(
      listenWhen: (previous, current) => current.bottomSheetStatus == .success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: BlocBuilder<InventoryBloc, InventoryState>(
        buildWhen: (previous, current) =>
            previous.bottomSheetStatus != current.bottomSheetStatus,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 10),
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
                ...part.stock
                    .where((stock) => stock.quantity > 0)
                    .map(
                      (stock) => UseStockListItem(
                        stock: stock,
                        isLoading: state.isLoadingBottomSheet,
                        onPressed: () => context.read<InventoryBloc>().add(
                          UseStockButtonPressed(
                            partId: part.partId,
                            storageId: stock.storageId,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
