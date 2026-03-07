import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_drawer.dart';
import 'package:inventory_app/inventory/widgets/inventory_part_card.dart';
import 'package:inventory_app/inventory/widgets/inventory_tool_bar.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(
        watchPartPresentations: context.read<WatchPartPresentations>(),
        stockRepository: context.read<StockRepository>(),
        tagRepository: context.read<TagRepository>(),
        storageRepository: context.read<StorageRepository>(),
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
      drawer: const InventoryDrawer(),
      bottomNavigationBar: const InventoryToolBar(),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Navigator.push(context, PartEditorPage.route()),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: .endContained,
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final parts = state.filteredParts;
          return Padding(
            padding: const .symmetric(horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding: const .fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Total items: '
                        '${state.filteredParts.length}',
                      ),
                      const Spacer(),
                      const Text('Show empty stock:'),
                      Transform.scale(
                        scale: 0.55,
                        child: Switch(
                          value: state.filter.quantityFilter == .all,
                          onChanged: (_) => context.read<InventoryBloc>().add(
                            const HideEmptyStockSwitchPressed(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: parts.length,
                    itemBuilder: (context, index) =>
                        InventoryPartCard(part: parts[index]),
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
