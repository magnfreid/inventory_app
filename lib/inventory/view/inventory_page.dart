import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication_gate/cubit/authentication_cubit.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_item_ui_model.dart';
import 'package:inventory_app/inventory_item_details/view/inventory_item_details_page.dart';
import 'package:inventory_app/inventory_item_editor/bloc/inventory_item_editor_bloc.dart';
import 'package:inventory_app/inventory_item_editor/view/inventory_item_editor_page.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(
        inventoryRepository: context.read<InventoryRepository>(),
        locationRepository: context.read<LocationRepository>(),
        productRepository: context.read<ProductRepository>(),
      ),
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                child: Align(
                  alignment: .bottomLeft,
                  child: Text('Choose your destiny'),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.shelves),
                title: Text('Storages'),
              ),
              const ListTile(
                leading: Icon(Icons.query_stats),
                title: Text('Statistics'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign out'),
                onTap: () => context.read<AuthenticationCubit>().signOut(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_downward),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          final bloc = InventoryItemEditorBloc(
            productRepository: context.read<ProductRepository>(),
          );
          await Navigator.push(
            context,
            InventoryItemEditorPage.route(bloc: bloc),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: .endContained,
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final items = state.items;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _InventoryItemCard(item: item);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InventoryItemCard extends StatelessWidget {
  const _InventoryItemCard({
    required this.item,
    super.key,
  });

  final InventoryItemUiModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () =>
            Navigator.push(context, InventoryItemDetailsPage.route(item: item)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(item.name),
                  Text(
                    item.detailNumber,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                    ),
                  ),
                  Text(item.brand ?? ''),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(item.totalQuantity.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
