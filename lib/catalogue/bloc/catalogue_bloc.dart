import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:inventory_app/catalogue/bloc/catalogue_state.dart';

part 'catalogue_event.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueState> {
  CatalogueBloc({required CatalogueRepository catalogueRepository})
    : _catalogueRepository = catalogueRepository,
      super(const CatalogueState()) {
    //TODO(magnfreid): Add debounce!
    on<_OnCatalogueItemsChanged>(_onCatalogueItemsChanged);

    _streamSubscription = _catalogueRepository.watchCatalogueItems().listen(
      (items) => add(_OnCatalogueItemsChanged(updates: items)),
    );
  }
  final CatalogueRepository _catalogueRepository;
  late final StreamSubscription<List<CatalogueItem>> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onCatalogueItemsChanged(
    _OnCatalogueItemsChanged event,
    Emitter<CatalogueState> emit,
  ) {
    emit(state.copyWith(status: .loaded, items: event.updates));
  }
}
