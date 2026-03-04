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

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(
        stockRepository: context.read<StockRepository>(),
        watchPartPresentations: context.read<WatchPartPresentations>(),
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
          final parts = state.parts;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: parts.length,
                  itemBuilder: (context, index) =>
                      InventoryPartCard(part: parts[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
