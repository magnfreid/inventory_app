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
      body: BlocBuilder<InventoryItemDetailsBloc, InventoryItemDetailsState>(
        buildWhen: (previous, current) =>
            previous.showAddView != current.showAddView ||
            previous.locations != current.locations,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: .start,
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
              ElevatedButton(
                onPressed: () => context.read<InventoryItemDetailsBloc>().add(
                  const ShowAddViewButtonPressed(),
                ),
                child: state.showAddView
                    ? const Text('Hide')
                    : const Text('Add to stock'),
              ),
              Padding(
                padding: const .all(16),
                child: AnimatedSwitcher(
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
                              onTap: () {},
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
              ),
            ],
          );
        },
      ),
    );
  }
}
