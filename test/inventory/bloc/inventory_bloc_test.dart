import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' as hydrated show Storage;
import 'package:hydrated_bloc/hydrated_bloc.dart' hide Storage;
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late WatchPartPresentations watchPartPresentations;
  late PartRepository partRepository;
  late StockRepository stockRepository;
  late TagRepository tagRepository;
  late StorageRepository storageRepository;
  late hydrated.Storage hydratedBlocStorage;
  late StreamController<List<PartPresentation>> partController;
  late StreamController<List<Storage>> storageController;
  late StreamController<List<Tag>> tagController;
  late PartPresentation part;
  late Tag brandTag;
  late Tag categoryTag;
  late Storage storage;

  setUp(() {
    hydratedBlocStorage = MockStorage();
    partRepository = MockPartRepository();
    stockRepository = MockStockRepository();
    tagRepository = MockTagRepository();
    storageRepository = MockStorageRepository();
    watchPartPresentations = MockWatchPartPresentations();

    partController = StreamController();
    tagController = StreamController();
    storageController = StreamController();

    part = PartPresentation(
      partId: '111',
      name: 'Test',
      detailNumber: '123',
      price: 123,
      isRecycled: true,
    );

    brandTag = Tag(id: '222', label: 'Brand', color: .blue, type: .brand);
    categoryTag = Tag(
      id: '456',
      label: 'Category',
      color: .amber,
      type: .category,
    );

    storage = Storage(id: '333', name: 'Storage');

    when(
      () => hydratedBlocStorage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = hydratedBlocStorage;

    when(
      () => partRepository.watchParts(),
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => storageRepository.watchStorages(),
    ).thenAnswer((_) => storageController.stream);

    when(
      () => stockRepository.watchStock(),
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => tagRepository.watchTags(),
    ).thenAnswer((_) => tagController.stream);

    when(
      () => watchPartPresentations(),
    ).thenAnswer((_) => partController.stream);
  });

  group('InventoryBloc', () {
    test('initial state test', () {
      final bloc = InventoryBloc(
        watchPartPresentations: watchPartPresentations,
        stockRepository: stockRepository,
        tagRepository: tagRepository,
        storageRepository: storageRepository,
      );

      expect(
        bloc.state,
        const InventoryState(),
      );
    });

    blocTest<InventoryBloc, InventoryState>(
      'emits loaded and parts when _PartUpdated is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) => partController.add([part]),
      expect: () => [
        isA<InventoryState>()
            .having((s) => s.parts, 'parts', [part])
            .having((s) => s.status, 'status', InventoryStateStatus.loaded),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits brandTags and categoryTags when _TagsUpdated is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) => tagController.add([brandTag, categoryTag]),
      expect: () => [
        isA<InventoryState>()
            .having((s) => s.brandTags, 'brandTags', [
              isA<TagPresentation>()
                  .having((t) => t.id, 'id', brandTag.id)
                  .having((t) => t.type, 'type', brandTag.type),
            ])
            .having((s) => s.categoryTags, 'categoryTags', [
              isA<TagPresentation>()
                  .having((t) => t.id, 'id', categoryTag.id)
                  .having((t) => t.type, 'type', categoryTag.type),
            ]),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits storages when _StoragesUpdated is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) => storageController.add([storage]),
      expect: () => [
        isA<InventoryState>().having((s) => s.storages, 'storages', [storage]),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [loading, success] when UseStockButtonPressed is added and stock '
      'is used successfully',
      build: () {
        when(
          () => stockRepository.decreaseStock(
            partId: '123',
            storageId: '123',
            amount: 1,
          ),
        ).thenAnswer((_) => Future.value());
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) => bloc.add(
        const UseStockButtonPressed(partId: '123', storageId: '123'),
      ),
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          InventoryStateBottomSheetStatus.loading,
        ),
        isA<InventoryState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          InventoryStateBottomSheetStatus.success,
        ),
      ],
      verify: (_) => verify(
        () => stockRepository.decreaseStock(
          partId: '123',
          storageId: '123',
          amount: 1,
        ),
      ).called(1),
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [loading, error] when UseStockButtonPressed is added and decrease '
      'fails',
      build: () {
        when(
          () => stockRepository.decreaseStock(
            partId: '123',
            storageId: '123',
            amount: 1,
          ),
        ).thenThrow(Exception('Error'));
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) => bloc.add(
        const UseStockButtonPressed(partId: '123', storageId: '123'),
      ),
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          InventoryStateBottomSheetStatus.loading,
        ),
        isA<InventoryState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          InventoryStateBottomSheetStatus.error,
        ),
      ],
      verify: (_) => verify(
        () => stockRepository.decreaseStock(
          partId: '123',
          storageId: '123',
          amount: 1,
        ),
      ).called(1),
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits inStock filter when HideEmptyStockSwitchPressed is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) => bloc.add(const HideEmptyStockSwitchPressed()),
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>().having(
            (filter) => filter.quantityFilter,
            'quantityFilter',
            QuantityFilter.inStock,
          ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits empty filter when ClearAllFiltersButtonPressed is added',
      build: () {
        final bloc = InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );

        bloc.emit(
          bloc.state.copyWith(
            filter: const InventoryFilter(
              brandFilters: {'BrandA', 'BrandB'},
              categoryFilters: {'CategoryA'},
              storageFilters: {'StorageA'},
            ),
          ),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(const ClearAllFiltersButtonPressed()),
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having(
                (filter) => filter.brandFilters,
                'quantityFilter',
                isEmpty,
              )
              .having(
                (filter) => filter.categoryFilters,
                'quantityFilter',
                isEmpty,
              )
              .having(
                (filter) => filter.storageFilters,
                'quantityFilter',
                isEmpty,
              ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits selected filters when FilterChipPressed is added and selected '
      ' filters are not already already selected',
      build: () {
        final bloc = InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );

        bloc.emit(
          bloc.state.copyWith(
            brandTags: [
              TagPresentation.fromDomainModel(brandTag),
              TagPresentation.fromDomainModel(
                Tag(id: 'Brand2', label: '', color: .amber, type: .brand),
              ),
            ],
            categoryTags: [
              TagPresentation.fromDomainModel(categoryTag),
              TagPresentation.fromDomainModel(
                Tag(id: 'Category2', label: '', color: .amber, type: .category),
              ),
            ],
            storages: [
              storage,
              Storage(id: '2', name: 'Storage2'),
            ],
          ),
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const FilterChipPressed(type: .brand, itemId: '123'));
        await Future<void>.delayed(const Duration(milliseconds: 250));
        bloc.add(const FilterChipPressed(type: .category, itemId: '456'));
        await Future<void>.delayed(const Duration(milliseconds: 250));
        bloc.add(const FilterChipPressed(type: .storage, itemId: '789'));
      },
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>().having(
            (filter) => filter.brandFilters,
            'brandFilters',
            contains('123'),
          ),
        ),
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having(
                (filter) => filter.brandFilters,
                'brandFilters',
                contains('123'),
              )
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                contains('456'),
              ),
        ),
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having(
                (filter) => filter.brandFilters,
                'brandFilters',
                contains('123'),
              )
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                contains('456'),
              )
              .having(
                (filter) => filter.storageFilters,
                'storageFilters',
                contains('789'),
              ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'does not emit selected filters when FilterChipPressed is added and '
      'filter is already selected',
      build: () {
        final bloc = InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );

        bloc.emit(
          bloc.state.copyWith(
            filter: InventoryFilter(
              brandFilters: {brandTag.id!},
              categoryFilters: {categoryTag.id!},
              storageFilters: {storage.id!},
            ),
            brandTags: [
              TagPresentation.fromDomainModel(brandTag),
              TagPresentation.fromDomainModel(
                Tag(id: 'Brand2', label: '', color: .amber, type: .brand),
              ),
            ],
            categoryTags: [
              TagPresentation.fromDomainModel(categoryTag),
              TagPresentation.fromDomainModel(
                Tag(id: 'Category2', label: '', color: .amber, type: .category),
              ),
            ],
            storages: [
              storage,
              Storage(id: '2', name: 'Storage2'),
            ],
          ),
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(FilterChipPressed(type: .brand, itemId: brandTag.id!));
        await Future<void>.delayed(const Duration(milliseconds: 250));
        bloc.add(FilterChipPressed(type: .category, itemId: categoryTag.id!));
        await Future<void>.delayed(const Duration(milliseconds: 250));
        bloc.add(FilterChipPressed(type: .storage, itemId: storage.id!));
      },
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>().having(
            (filter) => filter.brandFilters,
            'brandFilters',
            isEmpty,
          ),
        ),
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having((filter) => filter.brandFilters, 'brandFilters', isEmpty)
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                isEmpty,
              ),
        ),
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having((filter) => filter.brandFilters, 'brandFilters', isEmpty)
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                isEmpty,
              )
              .having(
                (filter) => filter.storageFilters,
                'storageFilters',
                isEmpty,
              ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits no filters when ClearFilterChipPressed is added',
      build: () {
        final bloc = InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );

        bloc.emit(
          bloc.state.copyWith(
            filter: InventoryFilter(
              brandFilters: {brandTag.id!},
              categoryFilters: {categoryTag.id!},
              storageFilters: {storage.id!},
            ),
            brandTags: [
              TagPresentation.fromDomainModel(brandTag),
              TagPresentation.fromDomainModel(
                Tag(id: 'Brand2', label: '', color: .amber, type: .brand),
              ),
            ],
            categoryTags: [
              TagPresentation.fromDomainModel(categoryTag),
              TagPresentation.fromDomainModel(
                Tag(id: 'Category2', label: '', color: .amber, type: .category),
              ),
            ],
            storages: [
              storage,
              Storage(id: '2', name: 'Storage2'),
            ],
          ),
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const ClearFilterChipPressed(type: .brand));
        await Future<void>.delayed(const Duration(milliseconds: 250));
        bloc.add(const ClearFilterChipPressed(type: .category));
        await Future<void>.delayed(const Duration(milliseconds: 250));
        bloc.add(const ClearFilterChipPressed(type: .storage));
      },
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having(
                (filter) => filter.brandFilters,
                'brandFilters',
                isEmpty,
              )
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                contains(categoryTag.id),
              )
              .having(
                (filter) => filter.storageFilters,
                'storageFilters',
                contains(storage.id),
              ),
        ),
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having((filter) => filter.brandFilters, 'brandFilters', isEmpty)
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                isEmpty,
              )
              .having(
                (filter) => filter.storageFilters,
                'storageFilters',
                contains(storage.id),
              ),
        ),
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>()
              .having((filter) => filter.brandFilters, 'brandFilters', isEmpty)
              .having(
                (filter) => filter.categoryFilters,
                'categoryFilters',
                isEmpty,
              )
              .having(
                (filter) => filter.storageFilters,
                'storageFilters',
                isEmpty,
              ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits search query filter when SearchQueryUpdated is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) async {
        bloc.add(const SearchQueryUpdated(searchString: 'search'));
      },
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>().having(
            (filter) => filter.searchQuery,
            'searchQuery',
            'search',
          ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits sortBy when SortByChipPressed is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) async {
        bloc.add(const SortByChipPressed(sortBy: .category));
      },
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>().having(
            (filter) => filter.sortByType,
            'sortByType',
            SortByType.category,
          ),
        ),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits isSortedAscending false when SortOrderButtonPressed is added',
      build: () {
        return InventoryBloc(
          watchPartPresentations: watchPartPresentations,
          stockRepository: stockRepository,
          tagRepository: tagRepository,
          storageRepository: storageRepository,
        );
      },
      act: (bloc) async {
        bloc.add(const SortOrderButtonPressed());
      },
      expect: () => [
        isA<InventoryState>().having(
          (s) => s.filter,
          'filter',
          isA<InventoryFilter>().having(
            (filter) => filter.isSortedAscending,
            'isSortedAscending',
            false,
          ),
        ),
      ],
    );
  });
}
