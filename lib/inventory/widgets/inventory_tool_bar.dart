import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/widgets/inventory_page_filter_bottom_sheet.dart';

class InventoryToolBar extends StatelessWidget {
  const InventoryToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilters = context
        .watch<InventoryBloc>()
        .state
        .filter
        .totalActiveFilters;
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
          Badge.count(
            isLabelVisible: activeFilters > 0,
            count: context
                .watch<InventoryBloc>()
                .state
                .filter
                .totalActiveFilters,
            child: IconButton(
              onPressed: () => showModalBottomSheet<void>(
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<InventoryBloc>(),
                  child: const InventoryPageFilterBottomSheet(),
                ),
              ),
              icon: const Icon(Icons.filter_list),
            ),
          ),
        ],
      ),
    );
  }
}
