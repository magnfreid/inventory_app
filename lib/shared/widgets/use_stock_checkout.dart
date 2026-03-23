import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';

class UseStockCheckout extends StatefulWidget {
  const UseStockCheckout({required this.stock, super.key});

  final StockPresentation stock;

  static MaterialPageRoute<void> route({required StockPresentation stock}) =>
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: UseStockCheckout(
              stock: stock,
            ),
          ),
        ),
      );

  @override
  State<UseStockCheckout> createState() => _UseStockCheckoutState();
}

class _UseStockCheckoutState extends State<UseStockCheckout> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserCubit>().state.maybeWhen(
      loaded: (user) => user.id,
      orElse: () => null,
    );
    final l10n = context.l10n;
    return Column(
      children: [
        const Text('Use buse duse!'),
        TextFormField(controller: _controller),
        AppButton(
          onPressed: userId == null
              ? null
              : () => context.read<InventoryBloc>().add(
                  UseStockButtonPressed(
                    partId: widget.stock.partId,
                    storageId: widget.stock.storageId,
                    userId: userId,
                    note: _controller.text,
                  ),
                ),
          label: l10n.saveButtonText,
        ),
      ],
    );
  }
}
