import 'package:storage_remote_data_source/storage_remote_data_source.dart';
import 'package:storage_repository/storage_repository.dart';

class StorageRepository {
  StorageRepository({
    required StorageRemoteDataSource remote,
  }) : _remote = remote;

  final StorageRemoteDataSource _remote;

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
