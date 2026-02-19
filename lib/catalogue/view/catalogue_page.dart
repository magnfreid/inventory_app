import 'dart:developer';

import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/catalogue/bloc/catalogue_bloc.dart';
import 'package:inventory_app/catalogue/bloc/catalogue_state.dart';

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
        label: const Text('New item'),
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
    return Card(
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
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 10),
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        onChanged: () => setState(() {
          _canSave = _formKey.currentState?.validate() ?? false;
        }),
        child: Column(
          mainAxisSize: .min,
          children: [
            const Text(
              'Add new part',
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              autovalidateMode: .always,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _detailNumberController,
              decoration: const InputDecoration(labelText: 'Detail Number'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              autovalidateMode: .always,
              keyboardType: TextInputType.number,
              validator: (value) => double.tryParse(value ?? '') == null
                  ? 'Enter a number'
                  : null,
            ),
            Padding(
              padding: const .symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  const Text('Recycled?'),
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
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const Spacer(),
            Padding(
              padding: const .symmetric(vertical: 8),
              child: BlocBuilder<CatalogueBloc, CatalogueState>(
                buildWhen: (previous, current) =>
                    previous.saveIsLoading != current.saveIsLoading,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _canSave ? () {} : null,
                      child: state.saveIsLoading
                          ? const Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const Text('Save'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
