import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class InventoryItemEditorPage extends StatelessWidget {
  const InventoryItemEditorPage({super.key});

  static MaterialPageRoute<void> route() => MaterialPageRoute<void>(
    builder: (context) => const InventoryItemEditorPage(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartEditorBloc(
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
      ),
      child: const InventoryItemEditorView(),
    );
  }
}

class InventoryItemEditorView extends StatefulWidget {
  const InventoryItemEditorView({super.key});

  @override
  State<InventoryItemEditorView> createState() =>
      _InventoryItemEditorViewState();
}

class _InventoryItemEditorViewState extends State<InventoryItemEditorView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _detailNumberController = TextEditingController();
  final _priceController = TextEditingController();
  final _brandController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isRecycled = false;
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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            onChanged: () => setState(
              () => _canSave = _formKey.currentState?.validate() ?? false,
            ),
            child: Column(
              mainAxisSize: .min,
              children: [
                Text(l10n.formFieldTitleText),
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
                Padding(
                  padding: const .symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(l10n.formFieldRecycledLabelText),
                      Switch.adaptive(
                        value: _isRecycled,
                        onChanged: (value) {
                          setState(() {
                            _isRecycled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),

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
                                    brand: _brandController.text,
                                    description: _descriptionController.text,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(l10n.formSaveButtonText),
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
