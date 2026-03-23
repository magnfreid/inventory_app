import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/stock/bloc/stock_bloc.dart';
import 'package:inventory_app/stock/bloc/stock_bloc_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:stock_repository/stock_repository.dart';

class StockCheckoutPage extends StatelessWidget {
  const StockCheckoutPage({required this.stock, super.key});

  final StockPresentation stock;

  static MaterialPageRoute<void> route({required StockPresentation stock}) =>
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: StockCheckoutPage(stock: stock),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc(
        stockRepository: context.read<StockRepository>(),
        stock: stock,
      ),
      child: const StockCheckoutView(),
    );
  }
}

class StockCheckoutView extends StatefulWidget {
  const StockCheckoutView({super.key});

  @override
  State<StockCheckoutView> createState() => _StockCheckoutViewState();
}

class _StockCheckoutViewState extends State<StockCheckoutView> {
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
        BlocBuilder<StockBloc, StockBlocState>(
          builder: (context, state) {
            return AppButton(
              isLoading: state.status == .loading,
              onPressed: userId == null
                  ? null
                  : () => context.read<StockBloc>().add(
                      UseStockButtonPressed(
                        userId: userId,
                        message: _controller.text,
                      ),
                    ),
              label: l10n.saveButtonText,
            );
          },
        ),
      ],
    );
  }
}
