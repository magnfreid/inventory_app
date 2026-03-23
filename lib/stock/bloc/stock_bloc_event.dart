part of 'stock_bloc.dart';

sealed class StockBlocEvent {
  const StockBlocEvent();
}

final class UseStockButtonPressed extends StockBlocEvent {
  const UseStockButtonPressed({required this.userId, required this.message});
  final String userId;
  final String message;
}
