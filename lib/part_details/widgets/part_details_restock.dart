import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:storage_repository/storage_repository.dart';

class PartDetailsRestock extends StatelessWidget {
  const PartDetailsRestock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartDetailsBloc, PartDetailsState>(
      listenWhen: (previous, current) =>
          previous.saveStatus != current.saveStatus &&
              current.saveStatus == .success ||
          current.saveStatus == .error,
      listener: (context, state) {
        Navigator.pop(context);
      },
      child: BlocBuilder<PartDetailsBloc, PartDetailsState>(
        builder: (context, state) {
          final part = state.part;
          final storages = state.storages;
          return part == null
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  spacing: 12,
                  crossAxisAlignment: .start,
                  children: [
                    const Text(
                      'Välj ett lager:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: storages.length,
                        itemBuilder: (context, index) {
                          final storage = storages[index];
                          final quantity =
                              part.stock
                                  .where(
                                    (stock) => stock.storageId == storage.id,
                                  )
                                  .firstOrNull
                                  ?.quantity ??
                              0;
                          return Card(
                            child: InkWell(
                              onTap: () => showModalBottomSheet<void>(
                                showDragHandle: true,
                                barrierLabel: 'Barrier',
                                context: context,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<PartDetailsBloc>(),
                                  child: _BottomSheet(
                                    partId: part.partId,
                                    storage: storage,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const .all(8),
                                child: Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(storage.name),
                                    Text(quantity.toString()),
                                  ],
                                ),
                              ),
                            ),
                          );
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

class _BottomSheet extends StatefulWidget {
  const _BottomSheet({
    required this.partId,
    required this.storage,
  });

  final Storage storage;
  final String partId;

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  late final TextEditingController _controller;
  int get value => int.tryParse(_controller.text) ?? 0;
  @override
  void initState() {
    _controller = TextEditingController(text: '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const .symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: .min,
          children: [
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                const Text(
                  'Lägg till i',
                  style: TextStyle(fontSize: 18),
                ),
                const Icon(Icons.arrow_right_alt),
                Text(
                  widget.storage.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const .symmetric(vertical: 16),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: .center,
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            final newValue = value - 1;
                            _controller.text = max(newValue, 0).toString();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: 70,
                          child: TextField(
                            textInputAction: .done,
                            keyboardType: .number,
                            textAlign: .center,
                            controller: _controller,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final newValue = value + 1;
                            _controller.text = newValue.toString();
                          },
                          icon: const Icon(Icons.add),
                        ),
                        Expanded(
                          child: IconButton.filled(
                            onPressed: () =>
                                context.read<PartDetailsBloc>().add(
                                  AddToStockButtonPressed(
                                    partId: widget.partId,
                                    storageId: widget.storage.id,
                                    amount: value,
                                  ),
                                ),
                            icon: const Icon(Icons.done),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // AppButton.text(
                  //   width: .wrap,
                  //   onPressed: () => context.read<PartDetailsBloc>().add(
                  //     AddToStockButtonPressed(
                  //       partId: widget.partId,
                  //       storageId: widget.storage.id,
                  //       amount: value,
                  //     ),
                  //   ),
                  //   label: 'Lägg till',
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
