import 'dart:developer';

import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/catalogue/bloc/catalogue_bloc.dart';
import 'package:inventory_app/catalogue/bloc/catalogue_state.dart';
import 'package:inventory_app/l10n/l10n.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatalogueBloc(
        catalogueRepository: context.read<CatalogueRepository>(),
      ),
      child: const CatalogueView(),
    );
  }
}

class CatalogueView extends StatelessWidget {
  const CatalogueView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet<Widget>(
            isScrollControlled: true,
            showDragHandle: true,
            useSafeArea: true,
            context: context,
            builder: (_) => _BottomSheetPage(
              catalogueBloc: context.read<CatalogueBloc>(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addNewCatalogueItemButtonText),
      ),
      body: BlocBuilder<CatalogueBloc, CatalogueState>(
        builder: (context, state) {
          final items = state.items;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _CatalogueItemCard(item: item);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CatalogueItemCard extends StatelessWidget {
  const _CatalogueItemCard({
    required this.item,
    super.key,
  });

  final CatalogueItem item;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(item.name),
                  Text(
                    item.detailNumber,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                    ),
                  ),
                  Text(item.brand ?? ''),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(item.price.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetPage extends StatelessWidget {
  const _BottomSheetPage({required this.catalogueBloc, super.key});

  final CatalogueBloc catalogueBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: catalogueBloc,
      child: const _BottomSheetView(),
    );
  }
}

class _BottomSheetView extends StatefulWidget {
  const _BottomSheetView({
    super.key,
  });

  @override
  State<_BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<_BottomSheetView> {
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
    return BlocListener<CatalogueBloc, CatalogueState>(
      listenWhen: (previous, current) => current.saveStatus == .success,
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: Padding(
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
                    Switch(
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
                child: BlocBuilder<CatalogueBloc, CatalogueState>(
                  buildWhen: (previous, current) =>
                      previous.isSaving != current.isSaving,
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canSave
                            ? () {
                                context.read<CatalogueBloc>().add(
                                  SaveButtonPressed(
                                    item: CatalogueItemCreate(
                                      name: _nameController.text,
                                      detailNumber:
                                          _detailNumberController.text,
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
                                );
                              }
                            : null,
                        child: state.isSaving
                            ? const Center(
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Padding(
                                    padding: EdgeInsets.all(3),
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
    );
  }
}
