part of 'products_bloc.dart';

sealed class ProductsEvent {
  const ProductsEvent();
}

final class _OnProductsChanged extends ProductsEvent {
  const _OnProductsChanged({required this.updates});
  final List<Product> updates;
}

final class SaveButtonPressed extends ProductsEvent {
  const SaveButtonPressed({required this.product});
  final Product product;
}
