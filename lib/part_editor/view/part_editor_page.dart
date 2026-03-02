import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartEditorPage extends StatelessWidget {
  const PartEditorPage({super.key});

  static MaterialPageRoute<void> route() => MaterialPageRoute<void>(
    builder: (context) => const PartEditorPage(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartEditorBloc(
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
      ),
      child: const PartEditorView(),
    );
  }
}

class PartEditorView extends StatefulWidget {
  const PartEditorView({super.key});

  @override
  State<PartEditorView> createState() => _PartEditorViewState();
}

class _PartEditorViewState extends State<PartEditorView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _detailNumberController = TextEditingController();
  final _priceController = TextEditingController();
  final _brandController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isRecycled = true;
  bool _canSave = false;

  @override
  void dispose() {
    _nameController.dispose();
    _detailNumberController.dispose();
    _priceController.dispose();
    _brandController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<PartEditorBloc, PartEditorState>(
      listenWhen: (previous, current) => current.isSuccess,
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.formFieldTitleText)),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            onChanged: () => setState(
              () => _canSave = _formKey.currentState?.validate() ?? false,
            ),
            child: Column(
              spacing: 10,
              mainAxisSize: .min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldNameLabelText}:',
                  ),
                  autovalidateMode: .onUserInteraction,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.validationRequired
                      : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldPriceLabelText}:',
                  ),
                  autovalidateMode: .onUserInteraction,
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? l10n.validationEnterNumber
                      : null,
                ),
                TextFormField(
                  controller: _detailNumberController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldDetailNumberLabelText}:',
                  ),
                ),
                TextFormField(
                  controller: _brandController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldBrandLabelText}:',
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldDescriptionLabelText}:',
                  ),
                ),
                Padding(
                  padding: const .symmetric(vertical: 24),
                  child: SegmentedButton<bool>(
                    segments: [
                      ButtonSegment<bool>(
                        value: false,
                        label: Text(l10n.formFieldNewLabelText),
                        icon: const Icon(Icons.inventory_outlined),
                      ),
                      ButtonSegment<bool>(
                        value: true,
                        label: Text(l10n.formFieldRecycledLabelText),
                        icon: const Icon(Icons.eco),
                      ),
                    ],
                    selected: {_isRecycled},
                    onSelectionChanged: (selection) {
                      setState(() {
                        _isRecycled = selection.first;
                      });
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const .symmetric(vertical: 8),
                  child: BlocBuilder<PartEditorBloc, PartEditorState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading,
                    builder: (context, state) {
                      return AppButton(
                        isLoading: state.isLoading,
                        onPressed: _canSave
                            ? () => context.read<PartEditorBloc>().add(
                                SaveButtonPressed(
                                  partCreateModel: PartCreate(
                                    name: _nameController.text,
                                    detailNumber: _detailNumberController.text,
                                    isRecycled: _isRecycled,
                                    price:
                                        double.tryParse(
                                          _priceController.text,
                                        ) ??
                                        0.0,
                                    //TODO(magnfreid): Add tags!
                                    mainTagId: null,
                                    brandTagId: null,
                                    standardTagIds: [],
                                    description: _descriptionController.text,
                                  ),
                                ),
                              )
                            : null,
                        label: l10n.formSaveButtonText,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
