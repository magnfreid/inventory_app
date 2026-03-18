import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_drawer.dart';
import 'package:inventory_app/inventory/widgets/inventory_part_card.dart';
import 'package:inventory_app/inventory/widgets/inventory_tool_bar.dart';
import 'package:inventory_app/shared/extensions/part_filtering_extension.dart';
import 'package:inventory_app/shared/utilities/bone_mocks.dart';

import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
    final userName = context.watch<UserCubit>().state.maybeWhen(
      loaded: (currentUser) => currentUser.name,
      orElse: () => '',
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(userName),
      ),
      drawer: const InventoryDrawer(),
      floatingActionButton: const InventoryToolBar(),
      floatingActionButtonLocation: .miniCenterFloat,
      body: SafeArea(
        top: false,
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            final parts = state.isLoading ? boneMockParts : state.filteredParts;
            return Skeletonizer(
              enabled: state.isLoading,
              child: parts.isEmpty
                  ? const Center(
                      child: Text('Nothing added yet!'),
                    )
                  : Padding(
                      padding: const .symmetric(horizontal: 8),
                      child: ListView.builder(
                        padding: const .only(bottom: 140),
                        itemCount: parts.length,
                        itemBuilder: (context, index) =>
                            InventoryPartCard(part: parts[index]),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
