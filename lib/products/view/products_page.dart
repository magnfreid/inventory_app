import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/products/bloc/products_bloc.dart';
import 'package:inventory_app/products/bloc/products_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:product_repository/product_repository.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(
        productRepository: context.read<ProductRepository>(),
      ),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

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
              catalogueBloc: context.read<ProductsBloc>(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addNewCatalogueItemButtonText),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
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

  final Product item;

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

  final ProductsBloc catalogueBloc;

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
    return BlocListener<ProductsBloc, ProductsState>(
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
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  buildWhen: (previous, current) =>
                      previous.isSaving != current.isSaving,
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canSave
                            ? () {
                                // context.read<ProductsBloc>().add(
                                //   SaveButtonPressed(
                                //     product: CatalogueItemCreate(
                                //       name: _nameController.text,
                                //       detailNumber:
                                //           _detailNumberController.text,
                                //       isRecycled: _isRecycled,
                                //       price:
                                //           double.tryParse(
                                //             _priceController.text,
                                //           ) ??
                                //           0.0,
                                //       brand: _brandController.text,
                                //       description: _descriptionController.text,
                                //     ),
                                //   ),
                                // );
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
