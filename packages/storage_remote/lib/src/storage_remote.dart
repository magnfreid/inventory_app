import 'models/storage_dto.dart';

abstract interface class StorageRemote {
  Stream<List<StorageDto>> watchStorages();
  Future<StorageDto> addStorage(StorageDto dto);
}
