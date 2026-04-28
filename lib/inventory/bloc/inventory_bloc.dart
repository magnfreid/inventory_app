import 'dart:async';

import 'package:core_remote/core_remote.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' hide Storage;
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/inventory/models/inventory_filter_type.dart';
import 'package:inventory_app/shared/utilities/bloc_transformers.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:storage_repository/storage_repository.dart';

part 'inventory_event.dart';

class InventoryBloc extends HydratedBloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required WatchPartPresentations watchPartPresentations,
  }) : super(const InventoryState()) {
    on<_PartsUpdated>(
      _onPartsUpdated,
      transformer: throttle(_streamThrottleDuration),
    );
    on<HideEmptyStockSwitchPressed>(_onHideEmptyStockSwitchPressed);
    on<ClearAllFiltersButtonPressed>(_onClearAllFiltersButtonPressed);
    on<FilterChipPressed>(
      _onFilterChipPressed,
      transformer: throttle(_uiThrottleDuration),
    );
    on<ClearFilterChipPressed>(_onClearFilterChipPressed);
    on<SearchQueryUpdated>(_onSearchQueryUpdated);
    on<SortByChipPressed>(
      _onSortByChipPressed,
      transformer: throttle(_uiThrottleDuration),
    );
    on<SortOrderButtonPressed>(
      _onSortOrderButtonPressed,
      transformer: throttle(_uiThrottleDuration),
    );
    on<_OnStreamError>(_onStreamError);

    _partsStreamSubscription = watchPartPresentations().listen(
      (parts) => add(_PartsUpdated(parts: parts)),
      onError: _handleStreamError,
    );
  }

  late final StreamSubscription<List<PartPresentation>>
  _partsStreamSubscription;

  final Duration _streamThrottleDuration = const Duration(milliseconds: 500);
  final Duration _uiThrottleDuration = const Duration(milliseconds: 200);

  @override
  Future<void> close() async {
    await _partsStreamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onPartsUpdated(
    _PartsUpdated event,
    Emitter<InventoryState> emit,
  ) {
    final brandTagMap = <String, TagPresentation>{};
    final categoryTagMap = <String, TagPresentation>{};
    final generalTagMap = <String, TagPresentation>{};
    final storageMap = <String, Storage>{};

    for (final part in event.parts) {
      final brand = part.brandTag;
      if (brand != null) brandTagMap[brand.id] = brand;

      final category = part.categoryTag;
      if (category != null) categoryTagMap[category.id] = category;

      for (final tag in part.generalTags) {
        generalTagMap[tag.id] = tag;
      }

      for (final stock in part.stock) {
        storageMap[stock.storageId] = Storage(
          id: stock.storageId,
          name: stock.storageName,
        );
      }
    }

    emit(
      state.copyWith(
        status: .loaded,
        parts: event.parts,
        error: null,
        brandTags: brandTagMap.values.toList(),
        categoryTags: categoryTagMap.values.toList(),
        generalTags: generalTagMap.values.toList(),
        storages: storageMap.values.toList(),
      ),
    );
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
          generalTagFilters: {},
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
      case .general:
        targetFilterSet = filter.generalTagFilters.toSet();
        totalLength = state.generalTags.length;
    }
    _toggleFilterIdInSet(event.itemId, targetFilterSet);
    if (totalLength > 1 && targetFilterSet.length >= totalLength) {
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
      case .general:
        emit(
          state.copyWith(
            filter: state.filter.copyWith(
              generalTagFilters: targetFilterSet,
            ),
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
      case .general:
        emit(
          state.copyWith(
            filter: state.filter.copyWith(generalTagFilters: {}),
          ),
        );
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

  FutureOr<void> _onSortOrderButtonPressed(
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

  FutureOr<void> _onStreamError(
    _OnStreamError event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(error: event.error));
  }

  void _toggleFilterIdInSet(String filterId, Set<String> set) {
    if (set.contains(filterId)) {
      set.remove(filterId);
    } else {
      set.add(filterId);
    }
  }

  @override
  InventoryState? fromJson(Map<String, dynamic> json) {
    return InventoryState(
      filter: InventoryFilter.fromJson(
        json['filter'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  Map<String, dynamic>? toJson(InventoryState state) {
    return {'filter': state.filter.toJson()};
  }

  void _handleStreamError(dynamic e) {
    final error = (e is RemoteException) ? e : const UnknownRemoteException();
    add(_OnStreamError(error: error));
  }
}
