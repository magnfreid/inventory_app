import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
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
    on<BrandFilterChipPressed>(_onBrandFilterChipPressed);
    on<ClearBrandFilterChipPressed>(_onClearBrandFilterChipPressed);
    on<CategoryFilterChipPressed>(_onCategoryFilterChipPressed);
    on<ClearCategoryFilterChipPressed>(_onClearCategoryFilterChipPressed);
    on<StorageFilterChipPressed>(_onStorageFilterChipPressed);
    on<ClearStorageFilterChipPressed>(_onClearStorageFilterChipPressed);
    on<ClearAllFiltersButtonPressed>(_onClearAllFiltersButtonPressed);

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

  FutureOr<void> _onBrandFilterChipPressed(
    BrandFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    final brandTag = event.tagId;
    final brandFilters = state.filter.brandFilters.toSet();
    if (brandFilters.contains(brandTag)) {
      brandFilters.remove(brandTag);
    } else {
      brandFilters.add(brandTag);
    }
    if (brandFilters.length == state.brandTags.length) {
      brandFilters.clear();
    }
    emit(
      state.copyWith(filter: state.filter.copyWith(brandFilters: brandFilters)),
    );
  }

  FutureOr<void> _onCategoryFilterChipPressed(
    CategoryFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    final categoryTag = event.categoryId;
    final categoryFilters = state.filter.categoryFilters.toSet();
    if (categoryFilters.contains(categoryTag)) {
      categoryFilters.remove(categoryTag);
    } else {
      categoryFilters.add(categoryTag);
    }
    if (categoryFilters.length == state.categoryTags.length) {
      categoryFilters.clear();
    }
    emit(
      state.copyWith(
        filter: state.filter.copyWith(categoryFilters: categoryFilters),
      ),
    );
  }

  FutureOr<void> _onClearBrandFilterChipPressed(
    ClearBrandFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(filter: state.filter.copyWith(brandFilters: {})));
  }

  FutureOr<void> _onClearCategoryFilterChipPressed(
    ClearCategoryFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(filter: state.filter.copyWith(categoryFilters: {})));
  }

  FutureOr<void> _onStoragesUpdated(
    _StoragesUpdated event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(storages: event.storages));
  }

  FutureOr<void> _onStorageFilterChipPressed(
    StorageFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    final storage = event.storageId;
    final storageFilters = state.filter.storageFilters.toSet();
    if (storageFilters.contains(storage)) {
      storageFilters.remove(storage);
    } else {
      storageFilters.add(storage);
    }
    if (storageFilters.length == state.storages.length) {
      storageFilters.clear();
    }
    emit(
      state.copyWith(
        filter: state.filter.copyWith(storageFilters: storageFilters),
      ),
    );
  }

  FutureOr<void> _onClearStorageFilterChipPressed(
    ClearStorageFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    emit(state.copyWith(filter: state.filter.copyWith(storageFilters: {})));
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
}
