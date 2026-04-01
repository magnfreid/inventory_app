import 'dart:async';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:image_repository/image_repository.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:image/image.dart' as img;
import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/helpers.dart';

/// Valid image bytes so [processImage] / decode succeed in image tests.
final _testImageFile = XFile.fromData(
  Uint8List.fromList(img.encodePng(img.Image(width: 1, height: 1))),
  name: 't.png',
);

void main() {
  late StockRepository stockRepository;
  late StorageRepository storageRepository;
  late PartRepository partRepository;
  late WatchSinglePartPresentation watchSinglePartPresentation;
  late ImageRepository imageRepository;
  late String partId;
  late String note;
  late String userId;
  late String downloadPath;
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
    imageRepository = MockImageRepository();
    partId = '123';
    downloadPath = 'download/path';
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

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(
      const Part(
        id: 'id',
        name: 'name',
        detailNumber: 'detailNumber',
        price: 10,
        isRecycled: true,
        generalTagIds: [],
        brandTagId: null,
        categoryTagId: null,
        description: 'description',
        imgPath: 'imgPath',
      ),
    );
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
        imageRepository: imageRepository,
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
        imageRepository: imageRepository,
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
        imageRepository: imageRepository,
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
            partId: any(named: 'partId'),
            storageId: any(named: 'storageId'),
            userId: any(named: 'userId'),
            userDisplayName: any(named: 'userDisplayName'),
            partName: any(named: 'partName'),
            detailNumber: any(named: 'detailNumber'),
            storageName: any(named: 'storageName'),
            unitPriceSnapshot: any(named: 'unitPriceSnapshot'),
            isRecycledPart: any(named: 'isRecycledPart'),
            note: any(named: 'note'),
          ),
        ).thenAnswer((_) async {
          return;
        });
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, storages: [storage]),
      act: (bloc) => bloc.add(
        UseButtonPressed(
          storageId: '123',
          userId: userId,
          userDisplayName: 'User',
          message: note,
        ),
      ),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.stockStatus,
          'stockStatus',
          PartDetailsStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.stockStatus,
          'stockStatus',
          PartDetailsStatus.done,
        ),
      ],
    );

    blocTest(
      'emits saveStatus [loading, done] and error when UseButtonPressed is '
      'added and fails',
      build: () {
        when(
          () => stockRepository.useStock(
            partId: any(named: 'partId'),
            storageId: any(named: 'storageId'),
            userId: any(named: 'userId'),
            userDisplayName: any(named: 'userDisplayName'),
            partName: any(named: 'partName'),
            detailNumber: any(named: 'detailNumber'),
            storageName: any(named: 'storageName'),
            unitPriceSnapshot: any(named: 'unitPriceSnapshot'),
            isRecycledPart: any(named: 'isRecycledPart'),
            note: any(named: 'note'),
          ),
        ).thenThrow(error);
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () =>
          PartDetailsState(part: part, storages: [storage], error: error),
      act: (bloc) => bloc.add(
        UseButtonPressed(
          storageId: '123',
          userId: userId,
          userDisplayName: 'User',
          message: note,
        ),
      ),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.stockStatus,
              'saveStatus',
              PartDetailsStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>()
            .having(
              (s) => s.stockStatus,
              'saveStatus',
              PartDetailsStatus.done,
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
            userDisplayName: any(named: 'userDisplayName'),
            partName: any(named: 'partName'),
            detailNumber: any(named: 'detailNumber'),
            storageName: any(named: 'storageName'),
            unitPriceSnapshot: any(named: 'unitPriceSnapshot'),
            isRecycledPart: any(named: 'isRecycledPart'),
            amount: any(named: 'amount'),
            note: any(named: 'note'),
          ),
        ).thenAnswer((_) async {});
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, storages: [storage]),
      act: (bloc) => bloc.add(
        AddToStockButtonPressed(
          storageId: '123',
          amount: 10,
          userId: userId,
          userDisplayName: 'User',
          note: note,
        ),
      ),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.stockStatus,
          'stockStatus',
          PartDetailsStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.stockStatus,
          'stockStatus',
          PartDetailsStatus.done,
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
            userDisplayName: any(named: 'userDisplayName'),
            partName: any(named: 'partName'),
            detailNumber: any(named: 'detailNumber'),
            storageName: any(named: 'storageName'),
            unitPriceSnapshot: any(named: 'unitPriceSnapshot'),
            isRecycledPart: any(named: 'isRecycledPart'),
            amount: any(named: 'amount'),
            note: any(named: 'note'),
          ),
        ).thenAnswer((_) async => throw error);

        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, storages: [storage]),
      act: (bloc) => bloc.add(
        AddToStockButtonPressed(
          storageId: '123',
          amount: 10,
          userId: userId,
          userDisplayName: 'User',
          note: note,
        ),
      ),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.stockStatus,
          'stockStatus',
          PartDetailsStatus.loading,
        ),
        isA<PartDetailsState>()
            .having(
              (s) => s.stockStatus,
              'stockStatus',
              PartDetailsStatus.done,
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
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(ConfirmDeletePartButtonPressed(partId: partId)),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.deleteStatus,
          'deleteStatus',
          PartDetailsStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.deleteStatus,
          'deleteStatus',
          PartDetailsStatus.done,
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
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, error: error),
      act: (bloc) => bloc.add(ConfirmDeletePartButtonPressed(partId: partId)),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.deleteStatus,
              'deleteStatus',
              PartDetailsStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>()
            .having(
              (s) => s.deleteStatus,
              'deleteStatus',
              PartDetailsStatus.done,
            )
            .having((s) => s.error, 'error', error),
      ],
    );

    blocTest(
      'emits imageStatus [loading, success] when ImageSelected is'
      ' added and is successful',
      build: () {
        when(
          () => imageRepository.uploadImage(
            partId: any(named: 'partId'),
            bytes: any(named: 'bytes'),
          ),
        ).thenAnswer((_) async => downloadPath);
        when(
          () => partRepository.editPart(any()),
        ).thenAnswer((_) async => part.toDomainModel());
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      act: (bloc) => bloc.add(ImageSelected(file: _testImageFile)),
      expect: () => [
        isA<PartDetailsState>().having(
          (s) => s.imageStatus,
          'imageStatus',
          PartDetailsStatus.loading,
        ),
        isA<PartDetailsState>().having(
          (s) => s.imageStatus,
          'imageStatus',
          PartDetailsStatus.done,
        ),
      ],
      wait: const Duration(seconds: 2),
    );

    blocTest(
      'emits imageStatus [loading, done] and error when ImageSelected is'
      ' added and fails',
      build: () {
        when(
          () => imageRepository.uploadImage(
            partId: any(named: 'partId'),
            bytes: any(named: 'bytes'),
          ),
        ).thenThrow(const InvalidArgumentRemoteException());
        when(
          () => partRepository.editPart(any()),
        ).thenAnswer((_) async => part.toDomainModel());
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, error: error),
      act: (bloc) => bloc.add(ImageSelected(file: _testImageFile)),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.imageStatus,
              'imageStatus',
              PartDetailsStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>()
            .having(
              (s) => s.imageStatus,
              'imageStatus',
              PartDetailsStatus.done,
            )
            .having((s) => s.error, 'error', isA<RemoteException>()),
      ],
      wait: const Duration(seconds: 2),
    );

    blocTest(
      'emits imageStatus [loading, success] when '
      'ConfirmDeleteImageButtonPressed is added and is successful',
      build: () {
        when(
          () => imageRepository.deleteImage(partId: partId),
        ).thenAnswer((_) async {});
        when(
          () => partRepository.editPart(any()),
        ).thenAnswer((_) async => part.toDomainModel());
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, error: error),
      act: (bloc) => bloc.add(ConfirmDeleteImageButtonPressed(part: part)),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.imageStatus,
              'imageStatus',
              PartDetailsStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>().having(
          (s) => s.imageStatus,
          'imageStatus',
          PartDetailsStatus.done,
        ),
      ],
    );

    blocTest(
      'emits imageStatus [loading, done] and error when '
      'ConfirmDeleteImageButtonPressed is added and fails',
      build: () {
        when(
          () => imageRepository.deleteImage(partId: partId),
        ).thenThrow(const InvalidArgumentRemoteException());
        when(
          () => partRepository.editPart(any()),
        ).thenAnswer((_) async => part.toDomainModel());
        return PartDetailsBloc(
          stockRepository: stockRepository,
          storageRepository: storageRepository,
          partRepository: partRepository,
          imageRepository: imageRepository,
          initialPart: part,
          watchSinglePartPresentation: watchSinglePartPresentation,
        );
      },
      seed: () => PartDetailsState(part: part, error: error),
      act: (bloc) => bloc.add(ConfirmDeleteImageButtonPressed(part: part)),
      expect: () => [
        isA<PartDetailsState>()
            .having(
              (s) => s.imageStatus,
              'imageStatus',
              PartDetailsStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartDetailsState>()
            .having(
              (s) => s.imageStatus,
              'imageStatus',
              PartDetailsStatus.done,
            )
            .having((s) => s.error, 'error', isA<RemoteException>()),
      ],
    );
  });
}
