import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

class PartDetailsInStock extends StatelessWidget {
  const PartDetailsInStock({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stocks = part.stock.where((stock) => stock.quantity > 0).toList()
      ..sort((a, b) => a.storageName.compareTo(b.storageName));
    return stocks.isEmpty
        ? Center(
            child: Text(l10n.inStockEmptyListText),
          )
        : Column(
            spacing: 12,
            crossAxisAlignment: .end,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text('${l10n.inStockTotalText}:'),
                    const Spacer(),
                    Text(part.totalQuantity.toString()),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: stocks.length,
                  itemBuilder: (context, index) {
                    final stock = stocks[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text(stock.storageName),
                          const Spacer(),
                          Text(stock.quantity.toString()),
                        ],
                      ),
                      trailing: AppButton.text(
                        onPressed: () => context.read<PartDetailsBloc>().add(
                          UseButtonPressed(
                            partId: part.partId,
                            storageId: stock.storageId,
                          ),
                        ),
                        label: l10n.inStockUseButtonLabelText,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
