import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/widgets/part_details_bottom_sheet.dart';
import 'package:inventory_app/part_details/widgets/part_details_info.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartDetailsPage extends StatelessWidget {
  const PartDetailsPage({required this.part, super.key});

  final PartUiModel part;

  static MaterialPageRoute<void> route({
    required PartUiModel item,
  }) => MaterialPageRoute<void>(
    builder: (context) => PartDetailsPage(
      part: item,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PartDetailsBloc(
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
      ),
      child: PartDetailsView(part: part),
    );
  }
}

class PartDetailsView extends StatelessWidget {
  const PartDetailsView({required this.part, super.key});

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(part.name),
      ),
      body: BlocListener<PartDetailsBloc, PartDetailsState>(
        listenWhen: (previous, current) => current.saveStatus == .success,
        listener: (context, state) => Navigator.of(context).pop(),
        child: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          buildWhen: (previous, current) =>
              previous.showAddView != current.showAddView ||
              previous.storages != current.storages,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: .start,
              children: [
                PartDetailsInfo(part),
                ElevatedButton(
                  onPressed: () => context.read<PartDetailsBloc>().add(
                    const ShowAddViewButtonPressed(),
                  ),
                  child: state.showAddView
                      ? const Text('Hide')
                      : const Text('Add to stock'),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: state.showAddView
                      ? Column(
                          children: state.storages.map((storage) {
                            final quantity = part.stock
                                .where(
                                  (element) => storage.id == element.storageId,
                                )
                                .firstOrNull
                                ?.quantity;
                            return ListTile(
                              onTap: () => showModalBottomSheet<void>(
                                context: context,
                                builder: (_) => Padding(
                                  padding: const .all(8),
                                  child: PartDetailsBottomSheet(
                                    amount: quantity ?? 0,
                                    storage: storage,
                                    onPressed: (amount) {
                                      context.read<PartDetailsBloc>().add(
                                        SaveButtonPressed(
                                          partId: part.partId,
                                          storageId: storage.id,
                                          amount: amount,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              title: Text(storage.name),
                              leadingAndTrailingTextStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              trailing: Text(
                                quantity != null
                                    ? quantity.toString()
                                    : 0.toString(),
                              ),
                            );
                          }).toList(),
                        )
                      : const SizedBox.shrink(
                          key: ValueKey('Empty'),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
