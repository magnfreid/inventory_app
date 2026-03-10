import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/inventory/models/inventory_filter_type.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';

import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required WatchPartPresentations watchPartPresentations,
    required StockRepository stockRepository,
    required TagRepository tagRepository,
    required StorageRepository storageRepository,
  }) : _stockRepository = stockRepository,
       _tagRepository = tagRepository,
       _storageRepository = storageRepository,
       super(const InventoryState()) {
    on<_PartsUpdated>(_onPartsUpdated);
    on<_TagsUpdated>(_onTagsUpdated);
    on<_StoragesUpdated>(_onStoragesUpdated);
    on<UseStockButtonPressed>(_onUseStockButtonPressed);
    on<HideEmptyStockSwitchPressed>(_onHideEmptyStockSwitchPressed);
    on<ClearAllFiltersButtonPressed>(_onClearAllFiltersButtonPressed);
    on<FilterChipPressed>(_onFilterChipPressed);
    on<ClearFilterChipPressed>(_onClearFilterChipPressed);
    on<SearchQueryUpdated>(_onSearchQueryUpdated);
    on<SortByChipPressed>(_onSortByChipPressed);
    on<SortOrderButtonPressed>(_sortOrderButtonPressed);

    _partsStreamSubscription = watchPartPresentations().listen(
      (parts) => add(_PartsUpdated(parts: parts)),
    );
    _tagsStreamSubscription = _tagRepository.watchTags().listen((tags) {
      final tagPresentations = tags
          .map(TagPresentation.fromDomainModel)
          .toList();
      add(_TagsUpdated(tags: tagPresentations));
    });
    _storagesStreamSubscription = _storageRepository.watchStorages().listen(
      (storages) => add(_StoragesUpdated(storages: storages)),
    );
  }

  final StockRepository _stockRepository;
  final TagRepository _tagRepository;
  final StorageRepository _storageRepository;
  late final StreamSubscription<List<PartPresentation>>
  _partsStreamSubscription;
  late final StreamSubscription<List<Tag>> _tagsStreamSubscription;
  late final StreamSubscription<List<Storage>> _storagesStreamSubscription;

  @override
  Future<void> close() async {
    await _partsStreamSubscription.cancel();
    await _tagsStreamSubscription.cancel();
    await _storagesStreamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onPartsUpdated(
    _PartsUpdated event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(parts: event.parts));
  }

  FutureOr<void> _onTagsUpdated(
    _TagsUpdated event,
    Emitter<InventoryState> emit,
  ) {
    final brandTags = event.tags.where((tag) => tag.type == .brand).toList();
    final catagoryTags = event.tags
        .where((tag) => tag.type == .category)
        .toList();
    emit(state.copyWith(brandTags: brandTags, categoryTags: catagoryTags));
  }

  FutureOr<void> _onUseStockButtonPressed(
    UseStockButtonPressed event,
    Emitter<InventoryState> emit,
  ) async {
    emit(state.copyWith(bottomSheetStatus: .loading));
    try {
      await _stockRepository.decreaseStock(
        partId: event.partId,
        storageId: event.storageId,
        amount: 1,
      );
      emit(state.copyWith(bottomSheetStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(bottomSheetStatus: .error));
    }
  }

  FutureOr<void> _onHideEmptyStockSwitchPressed(
    HideEmptyStockSwitchPressed event,
    Emitter<InventoryState> emit,
  ) {
    final currentFilter = state.filter.quantityFilter;

    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          quantityFilter: currentFilter == .all ? .inStock : .all,
        ),
      ),
    );
  }

  FutureOr<void> _onStoragesUpdated(
    _StoragesUpdated event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(storages: event.storages));
  }

  FutureOr<void> _onClearAllFiltersButtonPressed(
    ClearAllFiltersButtonPressed event,
    Emitter<InventoryState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          brandFilters: {},
          categoryFilters: {},
          storageFilters: {},
        ),
      ),
    );
  }

  FutureOr<void> _onFilterChipPressed(
    FilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    final filter = state.filter;
    Set<String> targetFilterSet;
    int totalLength;

    switch (event.type) {
      case .brand:
        targetFilterSet = filter.brandFilters.toSet();
        totalLength = state.brandTags.length;
      case .category:
        targetFilterSet = filter.categoryFilters.toSet();
        totalLength = state.categoryTags.length;
      case .storage:
        targetFilterSet = filter.storageFilters.toSet();
        totalLength = state.storages.length;
    }
    _toggleFilterIdInSet(event.itemId, targetFilterSet);
    if (targetFilterSet.length >= totalLength) {
      targetFilterSet.clear();
    }
    switch (event.type) {
      case .brand:
        emit(
          state.copyWith(
            filter: state.filter.copyWith(brandFilters: targetFilterSet),
          ),
        );
      case .category:
        emit(
          state.copyWith(
            filter: state.filter.copyWith(categoryFilters: targetFilterSet),
          ),
        );
      case .storage:
        emit(
          state.copyWith(
            filter: state.filter.copyWith(storageFilters: targetFilterSet),
          ),
        );
    }
  }

  FutureOr<void> _onClearFilterChipPressed(
    ClearFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    switch (event.type) {
      case .brand:
        emit(state.copyWith(filter: state.filter.copyWith(brandFilters: {})));
      case .category:
        emit(
          state.copyWith(filter: state.filter.copyWith(categoryFilters: {})),
        );
      case .storage:
        emit(state.copyWith(filter: state.filter.copyWith(storageFilters: {})));
    }
  }

  FutureOr<void> _onSearchQueryUpdated(
    SearchQueryUpdated event,
    Emitter<InventoryState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(searchQuery: event.searchString),
      ),
    );
  }

  FutureOr<void> _onSortByChipPressed(
    SortByChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    emit(
      state.copyWith(filter: state.filter.copyWith(sortByType: event.sortBy)),
    );
  }

  FutureOr<void> _sortOrderButtonPressed(
    SortOrderButtonPressed event,
    Emitter<InventoryState> emit,
  ) {
    final isAscending = state.filter.isSortedAscending;
    emit(
      state.copyWith(
        filter: state.filter.copyWith(isSortedAscending: !isAscending),
      ),
    );
  }

  void _toggleFilterIdInSet(String filterId, Set<String> set) {
    if (set.contains(filterId)) {
      set.remove(filterId);
    } else {
      set.add(filterId);
    }
  }
}
