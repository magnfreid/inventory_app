import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late StockRepository stockRepository;
  late StorageRepository storageRepository;
  late PartRepository partRepository;
  late WatchSinglePartPresentation watchSinglePartPresentation;
  late String partId;
  late Storage storage;
  late PartPresentation part;

  late StreamController<List<Storage>> storagesStream;
  late StreamController<PartPresentation> partStream;

  setUp(() {
    stockRepository = MockStockRepository();
    storageRepository = MockStorageRepository();
    partRepository = MockPartRepository();
    watchSinglePartPresentation = MockWatchSinglePartsPresentation();
    partId = '123';
    storagesStream = StreamController();
    partStream = StreamController();
    storage = Storage(id: '123', name: 'Storage');
    part = PartPresentation(
      partId: partId,
      name: 'Part',
      detailNumber: 'detail',
      price: 10,
      isRecycled: true,
    );

    when(
      () => stockRepository.watchStock(),
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => storageRepository.watchStorages(),
    ).thenAnswer((_) => storagesStream.stream);

    when(
      () => partRepository.watchParts(),
    ).thenAnswer((_) => const Stream.empty());

    when(
      () => watchSinglePartPresentation.call(partId),
    ).thenAnswer((_) => partStream.stream);
  });

  tearDown(() async {
    await partStream.close();
    await storagesStream.close();
  });

  group('PartDetailsBloc', () {
    test('initial state', () {
      final bloc = PartDetailsBloc(
        stockRepository: stockRepository,
        storageRepository: storageRepository,
        partRepository: partRepository,
        partId: partId,
        watchSinglePartPresentation: watchSinglePartPresentation,
      );

      expect(bloc.state, const PartDetailsState());
    });

    blocTest(
      'emits storages when _StoragesUpdated is added',
      build: () => PartDetailsBloc(
        stockRepository: stockRepository,
        storageRepository: storageRepository,
        partRepository: partRepository,
        partId: partId,
        watchSinglePartPresentation: watchSinglePartPresentation,
      ),
      act: (_) => storagesStream.add([storage]),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.storages,
          'storages',
          [storage],
        ),
      ],
    );

    blocTest(
      'emits part when _PartUpdated is added',
      build: () => PartDetailsBloc(
        stockRepository: stockRepository,
        storageRepository: storageRepository,
        partRepository: partRepository,
        partId: partId,
        watchSinglePartPresentation: watchSinglePartPresentation,
      ),
      act: (_) => partStream.add(part),
      expect: () => [
        isA<PartDetailsState>().having((s) => s.part, 'part', part),
      ],
    );

    blocTest(
      'emits content when ButtonSegmentPressed is added',
      build: () => PartDetailsBloc(
        stockRepository: stockRepository,
        storageRepository: storageRepository,
        partRepository: partRepository,
        partId: partId,
        watchSinglePartPresentation: watchSinglePartPresentation,
      ),
      act: (bloc) => bloc.add(const ButtonSegmentPressed(content: .restock)),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.content,
          'content',
          PartDetailsContent.restock,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, success] when UseButtonPressed is added and '
      'is successful',
      build: () {
        when(
          () => stockRepository.decreaseStock(
            partId: partId,
            storageId: '123',
            amount: 1,
          ),
        ).thenAnswer((_) async {});
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          partId: partId,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) =>
          bloc.add(UseButtonPressed(partId: partId, storageId: '123')),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.success,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, error] when UseButtonPressed is added and '
      'fails',
      build: () {
        when(
          () => stockRepository.decreaseStock(
            partId: partId,
            storageId: '123',
            amount: 1,
          ),
        ).thenThrow(Exception('Fail'));
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          partId: partId,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) =>
          bloc.add(UseButtonPressed(partId: partId, storageId: '123')),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.error,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, success] when AddToStockButtonPressed is '
      'added and is successful',
      build: () {
        when(
          () => stockRepository.increaseStock(
            partId: partId,
            storageId: '123',
            amount: 10,
          ),
        ).thenAnswer((_) async {});
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          partId: partId,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(
        AddToStockButtonPressed(partId: partId, storageId: '123', amount: 10),
      ),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.success,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, error] when AddToStockButtonPressed is added '
      'and fails',
      build: () {
        when(
          () => stockRepository.increaseStock(
            partId: partId,
            storageId: '123',
            amount: 10,
          ),
        ).thenThrow(Exception('Fail'));
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          partId: partId,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(
        AddToStockButtonPressed(partId: partId, storageId: '123', amount: 10),
      ),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.error,
        ),
      ],
    );

    blocTest(
      'emits deleteStatus [loading, success] when ConfirmDeleteButtonPressed is'
      ' added and is successful',
      build: () {
        when(() => partRepository.deletePart(partId)).thenAnswer((_) async {});
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          partId: partId,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(ConfirmDeleteButtonPressed(partId: partId)),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.deleteStatus,
          'deleteStatus',
          PartDetailsDeleteStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.deleteStatus,
          'deleteStatus',
          PartDetailsDeleteStatus.success,
        ),
      ],
    );

    blocTest(
      'emits deleteStatus [loading, error] when ConfirmDeleteButtonPressed is '
      ' added and fails',
      build: () {
        when(
          () => partRepository.deletePart(partId),
        ).thenThrow(Exception('Fail'));
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          partId: partId,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(ConfirmDeleteButtonPressed(partId: partId)),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.deleteStatus,
          'deleteStatus',
          PartDetailsDeleteStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.deleteStatus,
          'deleteStatus',
          PartDetailsDeleteStatus.error,
        ),
      ],
    );
  });
}
