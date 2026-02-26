import 'package:storage_remote/storage_remote.dart';
import 'package:storage_repository/storage_repository.dart';

class StorageRepository {
  StorageRepository({
    required StorageRemote remote,
  }) : _remote = remote;

  final StorageRemote _remote;

  Stream<List<Storage>> watchStorages() {
    return _remote.watchStorages().map(
      (dtos) => dtos.map(Storage.fromDto).toList(),
    );
  }

  Future<Storage> addStorage({
    required StorageCreateModel storageCreateModel,
  }) async {
    final dto = StorageDto(
      id: '',
      name: storageCreateModel.name,
      description: storageCreateModel.description,
    );

    final createdDto = await _remote.addStorage(dto);

    return Storage.fromDto(createdDto);
  }
}
