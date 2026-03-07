import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';

import 'package:stock_repository/stock_repository.dart';
import 'package:tag_repository/tag_repository.dart';

part 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({
    required WatchPartPresentations watchPartPresentations,
    required StockRepository stockRepository,
    required TagRepository tagRepository,
  }) : _stockRepository = stockRepository,
       _tagRepository = tagRepository,
       super(const InventoryState()) {
    on<_PartsUpdated>(_onPartsUpdated);
    on<_TagsUpdated>(_onTagsUpdated);
    on<UseStockButtonPressed>(_onUseStockButtonPressed);
    on<QuantityFilterChipPressed>(_onQuantityFilterChipPressed);
    on<BrandFilterChipPressed>(_onBrandFilterChipPressed);
    on<ClearBrandFilterChipPressed>(_onClearBrandFilterChipPressed);
    on<CategoryFilterChipPressed>(_onCategoryFilterChipPressed);
    on<ClearCategoryFilterChipPressed>(_onClearCategoryFilterChipPressed);

    _partsStreamSubscription = watchPartPresentations().listen(
      (parts) => add(_PartsUpdated(parts: parts)),
    );
    _tagsStreamSubscription = _tagRepository.watchTags().listen((tags) {
      final tagPresentations = tags
          .map(TagPresentation.fromDomainModel)
          .toList();
      add(_TagsUpdated(tags: tagPresentations));
    });
  }

  final StockRepository _stockRepository;
  final TagRepository _tagRepository;
  late final StreamSubscription<List<PartPresentation>>
  _partsStreamSubscription;
  late final StreamSubscription<List<Tag>> _tagsStreamSubscription;

  @override
  Future<void> close() async {
    await _partsStreamSubscription.cancel();
    await _tagsStreamSubscription.cancel();
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

  FutureOr<void> _onQuantityFilterChipPressed(
    QuantityFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    var quantityFilter = event.quantityFilter;
    final currentQuantityFilter = state.filter.quantityFilter;
    if (currentQuantityFilter != .all &&
        quantityFilter == currentQuantityFilter) {
      quantityFilter = .all;
    }
    final newFilter = state.filter.copyWith(quantityFilter: quantityFilter);

    emit(state.copyWith(filter: newFilter));
  }

  FutureOr<void> _onBrandFilterChipPressed(
    BrandFilterChipPressed event,
    Emitter<InventoryState> emit,
  ) {
    final brandTag = event.brandTag;
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
    final categoryTag = event.categoryTag;
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
}
