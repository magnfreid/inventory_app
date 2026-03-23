import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_bloc_state.freezed.dart';

enum StockBlocStateStatus { idle, loading, done }

@freezed
abstract class StockBlocState with _$StockBlocState {
  const factory StockBlocState({
    @Default(StockBlocStateStatus.idle) StockBlocStateStatus status,
  }) = _StockBlocState;
  const StockBlocState._();
}
