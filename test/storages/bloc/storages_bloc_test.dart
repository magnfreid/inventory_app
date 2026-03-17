import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late StorageRepository storageRepository;
  late Storage storage;
  late StreamController<List<Storage>> streamController;

  setUp(() {
    storageRepository = MockStorageRepository();
    storage = Storage(id: '123', name: 'Storage');
    streamController = StreamController();

    when(
      () => storageRepository.watchStorages(),
    ).thenAnswer((_) => streamController.stream);
  });

  tearDown(() async {
    await streamController.close();
  });

  group('Storagesbloc', () {
    test('initial state', () {
      final bloc = StoragesBloc(storageRepository: storageRepository);

      expect(bloc.state, const StoragesState());
    });

    blocTest(
      'emits storages when StoragesUpdated is added',
      build: () => StoragesBloc(storageRepository: storageRepository),
      act: (_) => streamController.add([storage]),
      expect: () => [
        isA<StoragesState>()
            .having((s) => s.status, 'status', StoragesStateStatus.loaded)
            .having((s) => s.storages, 'storages', contains(storage)),
      ],
    );
  });
}
