import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartQuickEditorPage extends StatelessWidget {
  const PartQuickEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartEditorBloc(
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
      ),
      child: const PartQuickEditorView(),
    );
  }
}

class PartQuickEditorView extends StatelessWidget {
  const PartQuickEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('YOLO!');
  }
}
