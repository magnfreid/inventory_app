import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:storage_repository/storage_repository.dart';

class RestockSheet extends StatefulWidget {
  const RestockSheet({super.key});

  @override
  State<RestockSheet> createState() => _RestockSheetState();
}

class _RestockSheetState extends State<RestockSheet> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .75,
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) => _StorageSelector.route(
          onStorageSelected: (storage) => _navigatorKey.currentState?.push(
            _RestockCheckout.route(storage: storage),
          ),
        ),
      ),
    );
  }
}

class _StorageSelector extends StatelessWidget {
  const _StorageSelector({required this.onStorageSelected});

  final void Function(Storage storage) onStorageSelected;

  static MaterialPageRoute<void> route({
    required void Function(Storage storage) onStorageSelected,
  }) => MaterialPageRoute(
    builder: (context) =>
        _StorageSelector(onStorageSelected: onStorageSelected),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<PartDetailsBloc, PartDetailsState>(
          listenWhen: (previous, current) =>
              previous.saveStatus != current.saveStatus &&
              current.saveStatus == .done,
          listener: (context, state) {
            Navigator.pop(context);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: context.colors.surfaceContainerLow,
        body: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          builder: (context, state) {
            final part = state.part;
            final storages = state.storages.toList()
              ..sort((a, b) => a.name.compareTo(b.name));
            return Padding(
              padding: const .all(24),
              child: Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Välj lager att fylla på:',
                    style: context.text.bodyLarge,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
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
                      return Row(
                        children: [
                          Text(storage.name),
                          const Spacer(),
                          Text(quantity.toString()),
                          IconButton(
                            onPressed: () => onStorageSelected(storage),
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: context.colors.primary,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('${l10n.inStockTotalText}:'),
                        const Spacer(),
                        Text(part.totalQuantity.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RestockCheckout extends StatefulWidget {
  const _RestockCheckout({
    required this.storage,
  });

  final Storage storage;

  static MaterialPageRoute<void> route({
    required Storage storage,
  }) => MaterialPageRoute(
    builder: (context) => _RestockCheckout(storage: storage),
  );

  @override
  State<_RestockCheckout> createState() => _RestockCheckoutState();
}

class _RestockCheckoutState extends State<_RestockCheckout> {
  late final TextEditingController _controller;
  int get value => int.tryParse(_controller.text) ?? 0;
  @override
  void initState() {
    _controller = TextEditingController(text: '0');
    _controller.addListener(() {
      final value = _controller.text;
      final intValue = int.tryParse(value);

      setState(() {
        if (intValue != null) {
          canSave = intValue > 0;
        }
      });
    });
    super.initState();
  }

  bool canSave = false;

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserCubit>().state.maybeWhen(
      loaded: (currentUser) => currentUser.id,
      orElse: () => null,
    );
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colors.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: context.colors.surfaceContainerLow,
      ),
      body: SingleChildScrollView(
        padding: .only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Padding(
          padding: const .symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: .min,
            children: [
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  Text(
                    l10n.restockAddStockSheetTitleText,
                    style: context.text.bodyLarge,
                  ),
                  const Icon(Icons.arrow_right_alt),
                  Text(
                    widget.storage.name,
                    style: context.text.bodyLarge,
                  ),
                ],
              ),
              Padding(
                padding: const .all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const .symmetric(vertical: 20),
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
                            width: 75,
                            child: TextField(
                              decoration: const InputDecoration(
                                floatingLabelAlignment: .center,
                                label: Text('Antal'),
                              ),
                              style: context.text.bodyLarge,
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
                            child: Row(
                              children: [
                                IconButton.filled(
                                  onPressed: canSave && userId != null
                                      ? () =>
                                            context.read<PartDetailsBloc>().add(
                                              AddToStockButtonPressed(
                                                storageId:
                                                    widget.storage.id ?? '',
                                                amount: value,
                                                userId: userId,
                                                note: null,
                                              ),
                                            )
                                      : null,
                                  icon: const Icon(Icons.done),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
