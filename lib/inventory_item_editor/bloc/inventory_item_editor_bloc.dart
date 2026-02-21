import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory_item_editor/bloc/inventory_item_editor_state.dart';
import 'package:product_repository/product_repository.dart';

part 'inventory_item_editor_event.dart';

class InventoryItemEditorBloc
    extends Bloc<InventoryItemEditorEvent, InventoryItemEditorState> {
  InventoryItemEditorBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(const InventoryItemEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  final ProductRepository _productRepository;

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<InventoryItemEditorState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _productRepository.addProduct(event.productCreateModel);
      emit(state.copyWith(status: .success));
    } on Exception catch (_) {
      emit(state.copyWith(status: .error));
    }
  }
}
