import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/part_editor/view/part_quick_editor_page.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
        tagRepository: context.read<TagRepository>(),
      ),
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const _Drawer(),
      bottomNavigationBar: const _ToolBar(),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () =>
            Navigator.push(context, InventoryItemEditorPage.route()),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: .endContained,
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final parts = state.parts;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: parts.length,
                  itemBuilder: (context, index) =>
                      _PartCard(part: parts[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final l10n = context.l10n;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Align(
                alignment: .bottomLeft,
                child: Text(l10n.drawerHeaderText),
              ),
            ),
            SegmentedButton<ThemeMode>(
              style: SegmentedButton.styleFrom(),
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: .system,
                  icon: Icon(Icons.system_security_update),
                ),
                ButtonSegment<ThemeMode>(
                  value: .light,
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: .dark,
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) => context
                  .read<ThemeCubit>()
                  .themeButtonPressed(selection.first),
            ),

            ListTile(
              leading: const Icon(Icons.shelves),
              title: Text(l10n.drawerLocationsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, StoragesPage.route()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.query_stats),
              title: Text(l10n.drawerStatisticsLinkText),
              onTap: () {
                Navigator.pop(context);
                unawaited(Navigator.push(context, StatisticsPage.route()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.drawerSettingsLinkText),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(l10n.drawerSignOutActionText),
              onTap: () => context.read<AuthenticationCubit>().signOut(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartCard extends StatelessWidget {
  const _PartCard({
    required this.part,
  });

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, PartDetailsPage.route(item: part)),
        onLongPress: () => showModalBottomSheet<void>(
          showDragHandle: true,
          context: context,
          builder: (context) => PartQuickEditorPage(
            part: part,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            part.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            part.detailNumber,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          part.totalQuantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.3,
                  ),
                  Wrap(
                    children: part.stock
                        .where((stock) => stock.quantity > 0)
                        .map(
                          (stock) => Card.outlined(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            child: Padding(
                              padding: const .all(5),
                              child: Text(
                                '${stock.locationName.toUpperCase()}'
                                ' ${stock.quantity}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            if (part.isRecycled)
              const Positioned(
                top: 3,
                right: 3,
                child: Icon(
                  size: 16,
                  Icons.eco,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
