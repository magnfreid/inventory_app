import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/models/part_ui_model.dart';
import 'package:inventory_app/l10n/l10n.dart';
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
    final l10n = context.l10n;
    return BlocListener<PartEditorBloc, PartEditorState>(
      listenWhen: (previous, current) => current.isSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      child: BlocBuilder<PartEditorBloc, PartEditorState>(
        buildWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        part.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        part.detailNumber,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ...part.stock
                    .where((stock) => stock.quantity > 0)
                    .map(
                      (stock) => Card.outlined(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                stock.locationName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 60,
                                  ),
                                  child: Card.filled(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      child: Center(
                                        child: Text(
                                          stock.quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: AppButton(
                                  width: .wrap,
                                  isLoading: state.isLoading,
                                  onPressed: () =>
                                      context.read<PartEditorBloc>().add(
                                        UseButtonPressed(
                                          partId: part.partId,
                                          storageId: stock.storageId,
                                        ),
                                      ),
                                  label: l10n.useButtonText,
                                ),
                              ),
                            ],
                          ),
                        ),
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
