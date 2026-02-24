import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/models/inventory_item_ui_model.dart';
import 'package:inventory_app/inventory_item_details/bloc/inventory_item_details_bloc.dart';
import 'package:inventory_app/inventory_item_details/bloc/inventory_item_details_state.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';

class InventoryItemDetailsPage extends StatelessWidget {
  const InventoryItemDetailsPage({required this.item, super.key});

  final InventoryItemUiModel item;

  static MaterialPageRoute<void> route({
    required InventoryItemUiModel item,
  }) => MaterialPageRoute<void>(
    builder: (context) => InventoryItemDetailsPage(
      item: item,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InventoryItemDetailsBloc(
        inventoryRepository: context.read<InventoryRepository>(),
        locationRepository: context.read<LocationRepository>(),
      ),
      child: InventoryItemDetailsView(item: item),
    );
  }
}

class InventoryItemDetailsView extends StatelessWidget {
  const InventoryItemDetailsView({required this.item, super.key});

  final InventoryItemUiModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<InventoryItemDetailsBloc, InventoryItemDetailsState>(
        listenWhen: (previous, current) => current.saveStatus == .success,
        listener: (context, state) => Navigator.of(context).pop(),
        child: BlocBuilder<InventoryItemDetailsBloc, InventoryItemDetailsState>(
          buildWhen: (previous, current) =>
              previous.showAddView != current.showAddView ||
              previous.locations != current.locations,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: .start,
              children: [
                _Details(item),
                ElevatedButton(
                  onPressed: () => context.read<InventoryItemDetailsBloc>().add(
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
                          children: state.locations.map((location) {
                            final quantity = item.stock
                                .where(
                                  (element) =>
                                      location.id == element.locationId,
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
                                    location: location,
                                    onPressed: (amount) {
                                      context
                                          .read<InventoryItemDetailsBloc>()
                                          .add(
                                            SaveButtonPressed(
                                              productId: item.productId,
                                              locationId: location.id,
                                              amount: amount,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                              ),
                              title: Text(location.name),
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
    required this.location,
    required this.onPressed,
  });

  final Location location;
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
            Text(widget.location.name),
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
  const _Details(this.item);

  final InventoryItemUiModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: const Text('Name'), subtitle: Text(item.name)),
        ListTile(
          title: const Text('Detail number'),
          subtitle: Text(item.detailNumber),
        ),
        ListTile(
          title: const Text('Price'),
          subtitle: Text(item.price.toString()),
        ),
      ],
    );
  }
}
