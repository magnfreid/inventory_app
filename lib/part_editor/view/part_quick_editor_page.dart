import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartQuickEditorPage extends StatelessWidget {
  const PartQuickEditorPage({required this.part, super.key});

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartEditorBloc(
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
      ),
      child: PartQuickEditorView(part: part),
    );
  }
}

class PartQuickEditorView extends StatelessWidget {
  const PartQuickEditorView({required this.part, super.key});

  final PartUiModel part;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartEditorBloc, PartEditorState>(
      listenWhen: (previous, current) => current.isSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      child: BlocBuilder<PartEditorBloc, PartEditorState>(
        buildWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          return Column(
            children: part.stock
                .where((stock) => stock.quantity > 0)
                .map(
                  (stock) => Row(
                    children: [
                      Text(stock.locationName),
                      const Spacer(),
                      Text(stock.quantity.toString()),
                      AppButton(
                        isLoading: state.isLoading,
                        onPressed: () => context.read<PartEditorBloc>().add(
                          UseButtonPressed(
                            partId: part.partId,
                            storageId: stock.storageId,
                          ),
                        ),
                        child: const Text('Use'),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
