import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/stock/bloc/stock_bloc_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:stock_repository/stock_repository.dart';

part 'stock_bloc_event.dart';

class StockBloc extends Bloc<StockBlocEvent, StockBlocState> {
  StockBloc({required this.stock, required StockRepository stockRepository})
    : _stockRepository = stockRepository,
      super(const StockBlocState()) {
    on<UseStockButtonPressed>(_onUseStockButtonPressed);
  }

  final StockRepository _stockRepository;
  final StockPresentation stock;

  FutureOr<void> _onUseStockButtonPressed(
    UseStockButtonPressed event,
    Emitter<StockBlocState> emit,
  ) {}
}
