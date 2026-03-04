import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_remote/storage_remote.dart';
import 'package:storage_repository/storage_repository.dart';

class MockStorageRemote extends Mock implements StorageRemote {}

void main() {
  late MockStorageRemote mockRemote;
  late StorageRepository repository;
  late StorageDto dto;
  late StorageCreateModel createModel;

  setUpAll(() {
    registerFallbackValue(
      StorageDto(id: 'fallback', name: '', description: ''),
    );
  });

  setUp(() {
    mockRemote = MockStorageRemote();
    repository = StorageRepository(remote: mockRemote);

    dto = StorageDto(id: '123', name: 'Storage1', description: 'Desc');

    createModel = StorageCreateModel(name: 'Storage1', description: 'Desc');
  });

  test('watchStorages maps DTOs to domain models', () async {
    when(
      () => mockRemote.watchStorages(),
    ).thenAnswer((_) => Stream.value([dto]));

    final storages = await repository.watchStorages().first;

    expect(storages.first.id, dto.id);
    expect(storages.first.name, dto.name);
    expect(storages.first.description, dto.description);
  });

  test('addStorage calls remote and returns domain model', () async {
    when(() => mockRemote.addStorage(any())).thenAnswer((_) async => dto);

    final result = await repository.addStorage(storageCreateModel: createModel);

    final captured = verify(() => mockRemote.addStorage(captureAny())).captured;
    final capturedDto = captured.first as StorageDto;
    expect(capturedDto.name, createModel.name);
    expect(capturedDto.description, createModel.description);

    expect(result.id, dto.id);
    expect(result.name, dto.name);
    expect(result.description, dto.description);
  });
}
