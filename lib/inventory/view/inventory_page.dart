import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_item_ui_model.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(
        inventoryRepository: context.read<InventoryRepository>(),
        locationRepository: context.read<LocationRepository>(),
        productRepository: context.read<ProductRepository>(),
      ),
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // shape: const CircularNotchedRectangle(),
        // padding: const .all(16),
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

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await showModalBottomSheet<Widget>(
            isScrollControlled: true,
            showDragHandle: true,
            useSafeArea: true,
            context: context,
            builder: (_) => _BottomSheetPage(
              inventoryBloc: context.read<InventoryBloc>(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: .endContained,
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          final items = state.items;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _InventoryItemCard(item: item);
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

class _InventoryItemCard extends StatelessWidget {
  const _InventoryItemCard({
    required this.item,
    super.key,
  });

  final InventoryItemUiModel item;

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
                Text(item.totalQuantity.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheetPage extends StatelessWidget {
  const _BottomSheetPage({required this.inventoryBloc, super.key});

  final InventoryBloc inventoryBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: inventoryBloc,
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
    return BlocListener<InventoryBloc, InventoryState>(
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
                child: BlocBuilder<InventoryBloc, InventoryState>(
                  buildWhen: (previous, current) =>
                      previous.isSaving != current.isSaving,
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canSave
                            ? () {
                                context.read<InventoryBloc>().add(
                                  SaveButtonPressed(
                                    ProductCreateModel(
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
    );
  }
}
