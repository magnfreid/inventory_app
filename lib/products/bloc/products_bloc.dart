import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/products/bloc/products_state.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';

part 'product_event.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required InventoryRepository inventoryRepository,
    required LocationRepository locationRepository,
    required ProductRepository productRepository,
  }) : _productRepository = productRepository,
       super(const ProductsState()) {
    //TODO(magnfreid): Add debounce!
    on<_OnProductsChanged>(_onProductsChanged);
    on<SaveButtonPressed>(_onAddButtonPressed);

    _streamSubscription = _productRepository.watchProducts().listen(
      (items) => add(_OnProductsChanged(updates: items)),
    );
  }

  final ProductRepository _productRepository;
  late final StreamSubscription<List<Product>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onAddButtonPressed(
    SaveButtonPressed event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(saveStatus: .loading));
    try {
      await _productRepository.addProduct(event.product);
      emit(state.copyWith(saveStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(saveStatus: .error));
    }
  }

  FutureOr<void> _onProductsChanged(
    _OnProductsChanged event,
    Emitter<ProductsState> emit,
  ) {
    emit(state.copyWith(status: .loaded, items: event.updates));
  }
}
