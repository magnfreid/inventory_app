import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory_item_editor/bloc/inventory_item_editor_bloc.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';

class InventoryItemQuickEditorPage extends StatelessWidget {
  const InventoryItemQuickEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryItemEditorBloc(
        inventoryRepository: context.read<InventoryRepository>(),
        locationRepository: context.read<LocationRepository>(),
        productRepository: context.read<ProductRepository>(),
      ),
      child: const InventoryItemQuickEditorView(),
    );
  }
}

class InventoryItemQuickEditorView extends StatelessWidget {
  const InventoryItemQuickEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('YOLO!');
  }
}
