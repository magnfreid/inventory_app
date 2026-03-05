import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/shared/widgets/use_stock_list_item.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class PartDetailsInStock extends StatelessWidget {
  const PartDetailsInStock({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final stocks = part.stock.where((stock) => stock.quantity > 0).toList();
    return stocks.isEmpty
        ? const Center(
            child: Text('Finns ej i lager.'),
          )
        : Column(
            spacing: 12,
            crossAxisAlignment: .end,
            children: [
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    part.totalQuantity.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stocks.length,
                  itemBuilder: (context, index) {
                    final stock = stocks[index];
                    return Card(
                      child: Padding(
                        padding: const .all(8),
                        child: Row(
                          spacing: 20,
                          children: [
                            Text(
                              stock.storageName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Spacer(),
                            Text(
                              stock.quantity.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            AppButton.text(
                              width: .wrap,
                              onPressed: () =>
                                  context.read<PartDetailsBloc>().add(
                                    UseButtonPressed(
                                      partId: part.partId,
                                      storageId: stock.storageId,
                                    ),
                                  ),
                              label: 'Förbruka',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
