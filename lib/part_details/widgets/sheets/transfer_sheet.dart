import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

/// Bottom sheet for transferring stock from one storage to another.
///
/// Presents a three-stage nested [Navigator]:
/// 1. Source storage is already selected (passed as [sourceStock]).
/// 2. Destination storage selector.
/// 3. Quantity + optional note, then confirm.
class TransferSheet extends StatefulWidget {
  /// Creates a [TransferSheet] pre-seeded with the [sourceStock] the user
  /// tapped on.
  const TransferSheet({required this.sourceStock, super.key});

  /// The stock entry the transfer will be deducted from.
  final StockPresentation sourceStock;

  @override
  State<TransferSheet> createState() => _TransferSheetState();
}

class _TransferSheetState extends State<TransferSheet> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartDetailsBloc, PartDetailsState>(
      listenWhen: (previous, current) =>
          previous.stockStatus != current.stockStatus &&
          current.stockStatus == .done,
      // Pop the bottom sheet from the outer navigator's context, which closes
      // the entire sheet regardless of how many routes the nested navigator
      // has on its stack.
      listener: (context, state) => Navigator.of(context).pop(),
      child: FractionallySizedBox(
        heightFactor: .75,
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) => _DestinationSelector.route(
            sourceStock: widget.sourceStock,
            onDestinationSelected: (destination) =>
                _navigatorKey.currentState?.push(
              _TransferCheckout.route(
                sourceStock: widget.sourceStock,
                destination: destination,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stage 1 — destination storage selector
// ---------------------------------------------------------------------------

class _DestinationSelector extends StatelessWidget {
  const _DestinationSelector({
    required this.sourceStock,
    required this.onDestinationSelected,
  });

  final StockPresentation sourceStock;
  final void Function(Storage destination) onDestinationSelected;

  static MaterialPageRoute<void> route({
    required StockPresentation sourceStock,
    required void Function(Storage destination) onDestinationSelected,
  }) => MaterialPageRoute(
    builder: (context) => _DestinationSelector(
      sourceStock: sourceStock,
      onDestinationSelected: onDestinationSelected,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colors.surfaceContainerLow,
      body: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          builder: (context, state) {
            // All storages except the source.
            final destinations = state.storages
                .where((s) => s.id != sourceStock.storageId)
                .toList()
              ..sort((a, b) => a.name.compareTo(b.name));

            return Padding(
              padding: const .all(24),
              child: Column(
                spacing: 12,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    l10n.transferSheetSelectDestinationTitle,
                    style: context.text.bodyLarge,
                  ),
                  Text(
                    '${l10n.from} ${sourceStock.storageName}'
                    ' (${sourceStock.quantity}'
                    ' ${l10n.pieces(sourceStock.quantity)})',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      physics: const ClampingScrollPhysics(),
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        final storage = destinations[index];
                        return ListTile(
                          title: Text(storage.name),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: context.colors.primary,
                          ),
                          onTap: () => onDestinationSelected(storage),
                        );
                      },
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

// ---------------------------------------------------------------------------
// Stage 2 — quantity + note
// ---------------------------------------------------------------------------

class _TransferCheckout extends StatefulWidget {
  const _TransferCheckout({
    required this.sourceStock,
    required this.destination,
  });

  final StockPresentation sourceStock;
  final Storage destination;

  static MaterialPageRoute<void> route({
    required StockPresentation sourceStock,
    required Storage destination,
  }) => MaterialPageRoute(
    builder: (context) => _TransferCheckout(
      sourceStock: sourceStock,
      destination: destination,
    ),
  );

  @override
  State<_TransferCheckout> createState() => _TransferCheckoutState();
}

class _TransferCheckoutState extends State<_TransferCheckout> {
  late final TextEditingController _quantityController;
  late final TextEditingController _noteController;

  int get _quantity => int.tryParse(_quantityController.text) ?? 0;
  int get _maxQuantity => widget.sourceStock.quantity;

  bool _canSave = false;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '1')
      ..addListener(_updateCanSave);
    _noteController = TextEditingController();
    _updateCanSave();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _updateCanSave() {
    setState(() => _canSave = _quantity > 0 && _quantity <= _maxQuantity);
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserCubit>().state.maybeWhen(
      loaded: (currentUser) => currentUser.id,
      orElse: () => null,
    );
    final userDisplayName = context.read<UserCubit>().state.maybeWhen(
      loaded: (currentUser) => currentUser.name,
      orElse: () => '',
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
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  Text(
                    widget.sourceStock.storageName,
                    style: context.text.bodyLarge?.copyWith(
                      color: context.colors.tertiary,
                    ),
                  ),
                  const Icon(Icons.arrow_right_alt),
                  Text(
                    widget.destination.name,
                    style: context.text.bodyLarge?.copyWith(
                      color: context.colors.tertiary,
                    ),
                  ),
                ],
              ),
              Text(
                l10n.transferSheetQuantityTitle,
                style: context.text.bodyMedium,
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: .center,
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      final newValue = max(_quantity - 1, 1);
                      _quantityController.text = newValue.toString();
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 75,
                    child: TextField(
                      decoration: InputDecoration(
                        floatingLabelAlignment: .center,
                        label: Text(l10n.quantity),
                      ),
                      style: context.text.bodyLarge,
                      textInputAction: .done,
                      keyboardType: .number,
                      textAlign: .center,
                      controller: _quantityController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final newValue = min(_quantity + 1, _maxQuantity);
                      _quantityController.text = newValue.toString();
                    },
                    icon: const Icon(Icons.add),
                  ),
                  Expanded(
                    child: Text(
                      '/ $_maxQuantity',
                      style: context.text.bodyMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _noteController,
                maxLines: 2,
                minLines: 1,
                maxLength: 100,
                decoration: InputDecoration(
                  label: Text(l10n.transferSheetNoteLabel),
                ),
              ),
              BlocBuilder<PartDetailsBloc, PartDetailsState>(
                builder: (context, state) {
                  return AppButton(
                    isLoading: state.stockStatus == .loading,
                    onPressed: _canSave && userId != null
                        ? () => context.read<PartDetailsBloc>().add(
                            TransferStockButtonPressed(
                              fromStorageId: widget.sourceStock.storageId,
                              toStorageId: widget.destination.id ?? '',
                              quantity: _quantity,
                              userId: userId,
                              userDisplayName: userDisplayName,
                              note: _noteController.text.isEmpty
                                  ? null
                                  : _noteController.text,
                            ),
                          )
                        : null,
                    label: l10n.saveButtonText,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
