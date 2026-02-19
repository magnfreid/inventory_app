import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_repository/product_repository.dart';

part 'products_state.freezed.dart';

enum ProductsStateStatus { loading, loaded }

enum ProductsStateSaveStatus { idle, loading, success, error }

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(ProductsStateStatus.loading) ProductsStateStatus status,
    @Default([]) List<Product> items,
    @Default(ProductsStateSaveStatus.idle) ProductsStateSaveStatus saveStatus,
  }) = _ProductsState;
  const ProductsState._();

  bool get isLoading => status == .loading;
  bool get isSaving => saveStatus == .loading;
}
