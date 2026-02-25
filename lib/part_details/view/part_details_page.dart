import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
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
      appBar: AppBar(),
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
                _Details(part),
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
                                  child: _BottomSheet(
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
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomSheet extends StatefulWidget {
  const _BottomSheet({
    required this.amount,
    required this.storage,
    required this.onPressed,
  });

  final Storage storage;
  final int amount;
  final void Function(int amount) onPressed;

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.amount.toString());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Add stock:'),
        Row(
          children: [
            Text(widget.storage.name),
            Expanded(
              child: TextField(
                controller: _controller,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = int.tryParse(
              _controller.text,
            );
            if (quantity == null || quantity == 0) return;
            widget.onPressed(quantity);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details(this.part);

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: const Text('Name'), subtitle: Text(part.name)),
        ListTile(
          title: const Text('Detail number'),
          subtitle: Text(part.detailNumber),
        ),
        ListTile(
          title: const Text('Price'),
          subtitle: Text(part.price.toString()),
        ),
      ],
    );
  }
}
