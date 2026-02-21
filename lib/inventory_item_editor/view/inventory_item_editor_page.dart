import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory_item_editor/bloc/inventory_item_editor_bloc.dart';
import 'package:inventory_app/inventory_item_editor/bloc/inventory_item_editor_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:product_repository/product_repository.dart';

class InventoryItemEditorPage extends StatelessWidget {
  const InventoryItemEditorPage({required this.bloc, super.key});

  final InventoryItemEditorBloc bloc;

  static MaterialPageRoute<void> route({
    required InventoryItemEditorBloc bloc,
  }) => MaterialPageRoute<void>(
    builder: (context) => InventoryItemEditorPage(
      bloc: bloc,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: const InventoryItemEditorView(),
    );
  }
}

class InventoryItemEditorView extends StatefulWidget {
  const InventoryItemEditorView({
    super.key,
  });

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
    return BlocListener<InventoryItemEditorBloc, InventoryItemEditorState>(
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
            onChanged: () => setState(() {
              _canSave = _formKey.currentState?.validate() ?? false;
            }),
            child: Column(
              mainAxisSize: .min,
              children: [
                Text(l10n.formFieldTitleText),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldNameLabelText}:',
                  ),
                  autovalidateMode: .always,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.validationRequired
                      : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: '${l10n.formFieldPriceLabelText}:',
                  ),
                  autovalidateMode: .always,
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
                  child:
                      BlocBuilder<
                        InventoryItemEditorBloc,
                        InventoryItemEditorState
                      >(
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _canSave
                                  ? () {
                                      context
                                          .read<InventoryItemEditorBloc>()
                                          .add(
                                            SaveButtonPressed(
                                              productCreateModel:
                                                  ProductCreateModel(
                                                    name: _nameController.text,
                                                    detailNumber:
                                                        _detailNumberController
                                                            .text,
                                                    isRecycled: _isRecycled,
                                                    price:
                                                        double.tryParse(
                                                          _priceController.text,
                                                        ) ??
                                                        0.0,
                                                    brand:
                                                        _brandController.text,
                                                    description:
                                                        _descriptionController
                                                            .text,
                                                  ),
                                            ),
                                          );
                                    }
                                  : null,
                              child: state.isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Padding(
                                          padding: .all(3),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 0.5,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(l10n.formSaveButtonText),
                            ),
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
