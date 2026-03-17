import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_bloc.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/mocks.dart';

void main() {
  late StorageRepository storageRepository;
  late Storage existingStorage;
  late Storage newStorage;

  setUp(() {
    storageRepository = MockStorageRepository();
    existingStorage = Storage(id: '123', name: 'Storage');
    newStorage = Storage(id: null, name: 'Storage');

    when(
      () => storageRepository.addStorage(storage: newStorage),
    ).thenAnswer((_) async => Future.value(newStorage));

    when(
      () => storageRepository.editStorage(storage: existingStorage),
    ).thenAnswer((_) async => Future.value(existingStorage));
  });

  group('StoragesEditorBloc', () {
    test('initial state', () {
      final bloc = StoragesEditorBloc(storageRepository: storageRepository);

      expect(bloc.state, const StoragesEditorState());
    });

    blocTest(
      'emits [loading, success] and addStorage when SaveButtonPressed is added '
      'with new storage and is successful',
      build: () => StoragesEditorBloc(storageRepository: storageRepository),
      act: (bloc) => bloc.add(SaveButtonPressed(storage: newStorage)),
      expect: () => [
        isA<StoragesEditorState>().having(
          (s) => s.status,
          'status',
          StoragesEditorStatus.loading,
        ),
        isA<StoragesEditorState>().having(
          (s) => s.status,
          'status',
          StoragesEditorStatus.success,
        ),
      ],
      verify: (_) {
        verify(
          () => storageRepository.addStorage(storage: newStorage),
        ).called(1);
      },
    );

    blocTest(
      'emits [loading, success] and editStorage is called when '
      'SaveButtonPressed is added with existing storage and is successful',
      build: () => StoragesEditorBloc(storageRepository: storageRepository),
      act: (bloc) => bloc.add(SaveButtonPressed(storage: existingStorage)),
      expect: () => [
        isA<StoragesEditorState>().having(
          (s) => s.status,
          'status',
          StoragesEditorStatus.loading,
        ),
        isA<StoragesEditorState>().having(
          (s) => s.status,
          'status',
          StoragesEditorStatus.success,
        ),
      ],
      verify: (_) {
        verify(
          () => storageRepository.editStorage(storage: existingStorage),
        ).called(1);
      },
    );

    blocTest(
      'emits [loading, idle] and addStorage is not called when '
      'SaveButtonPressed is added with existing storage and fails',
      build: () {
        when(
          () => storageRepository.editStorage(storage: existingStorage),
        ).thenThrow(Exception('Fail'));
        return StoragesEditorBloc(storageRepository: storageRepository);
      },
      act: (bloc) => bloc.add(SaveButtonPressed(storage: existingStorage)),
      expect: () => [
        isA<StoragesEditorState>().having(
          (s) => s.status,
          'status',
          StoragesEditorStatus.loading,
        ),
        isA<StoragesEditorState>().having(
          (s) => s.status,
          'status',
          StoragesEditorStatus.idle,
        ),
      ],
      verify: (_) {
        verify(
          () => storageRepository.editStorage(storage: existingStorage),
        ).called(1);
      },
    );
  });
}
