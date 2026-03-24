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
  late String note;
  late String userId;
  late Storage storage;
  late PartPresentation part;
  late Exception error;

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
    error = Exception('Fail');
    userId = '111';
    note = 'note';

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
        initialPart: part,
        watchSinglePartPresentation: watchSinglePartPresentation,
      );

      expect(bloc.state, PartDetailsState(part: part));
    });

    blocTest(
      'emits storages when _StoragesUpdated is added',
      build: () => PartDetailsBloc(
        stockRepository: stockRepository,
        storageRepository: storageRepository,
        partRepository: partRepository,
        initialPart: part,
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
        initialPart: part,
        watchSinglePartPresentation: watchSinglePartPresentation,
      ),
      act: (_) => partStream.add(part),
      expect: () => [
        isA<PartDetailsState>().having((s) => s.part, 'part', part),
      ],
    );

    blocTest(
      'emits saveStatus [loading, success] when UseButtonPressed is added and '
      'is successful',
      build: () {
        when(
          () => stockRepository.useStock(
            partId: partId,
            storageId: '123',
            userId: userId,
            note: note,
          ),
        ).thenAnswer((_) async {
          return;
        });
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(
        UseButtonPressed(storageId: '123', userId: userId, message: note),
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
          PartDetailsSaveStatus.done,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, done] and error when UseButtonPressed is '
      'added and fails',
      build: () {
        when(
          () => stockRepository.useStock(
            partId: partId,
            storageId: '123',
            userId: userId,
            note: note,
          ),
        ).thenThrow(error);
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, error: error),
      act: (bloc) => bloc.add(
        UseButtonPressed(storageId: '123', userId: userId, message: note),
      ),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.saveStatus,
              'saveStatus',
              PartDetailsSaveStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>()
            .having(
              (s) => s.saveStatus,
              'saveStatus',
              PartDetailsSaveStatus.done,
            )
            .having((s) => s.error, 'error', error),
      ],
    );

    blocTest(
      'emits saveStatus [loading, success] when AddToStockButtonPressed is '
      'added and is successful',
      build: () {
        when(
          () => stockRepository.restockStock(
            partId: any(named: 'partId'),
            storageId: any(named: 'storageId'),
            userId: any(named: 'userId'),
            amount: any(named: 'amount'),
            note: any(named: 'note'),
          ),
        ).thenAnswer((_) async => throw error);
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(
        AddToStockButtonPressed(
          storageId: '123',
          amount: 10,
          userId: userId,
          note: note,
        ),
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
          PartDetailsSaveStatus.done,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, done] and error when AddToStockButtonPressed '
      'fails',
      build: () {
        when(
          () => stockRepository.restockStock(
            partId: any(named: 'partId'),
            storageId: any(named: 'storageId'),
            userId: any(named: 'userId'),
            amount: any(named: 'amount'),
            note: any(named: 'note'),
          ),
        ).thenAnswer((_) async => throw error);

        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(
        AddToStockButtonPressed(
          storageId: '123',
          amount: 10,
          userId: userId,
          note: note,
        ),
      ),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.saveStatus,
          'saveStatus',
          PartDetailsSaveStatus.loading,
        ),
        isA<PartDetailsState>()
            .having(
              (s) => s.saveStatus,
              'saveStatus',
              PartDetailsSaveStatus.done,
            )
            .having((s) => s.error, 'error', error),
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
          initialPart: part,
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
          PartDetailsDeleteStatus.done,
        ),
      ],
    );

    blocTest(
      'emits deleteStatus [loading, done] and error when '
      'ConfirmDeleteButtonPressed is added and fails',
      build: () {
        when(
          () => partRepository.deletePart(partId),
        ).thenThrow(error);
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, error: error),
      act: (bloc) => bloc.add(ConfirmDeleteButtonPressed(partId: partId)),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.deleteStatus,
              'deleteStatus',
              PartDetailsDeleteStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>()
            .having(
              (s) => s.deleteStatus,
              'deleteStatus',
              PartDetailsDeleteStatus.done,
            )
            .having((s) => s.error, 'error', error),
      ],
    );
  });
}
