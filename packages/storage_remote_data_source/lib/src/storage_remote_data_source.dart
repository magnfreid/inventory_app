import 'package:storage_remote_data_source/src/models/storage_dto.dart';

abstract interface class StorageRemoteDataSource {
  Stream<List<StorageDto>> watchStorages();
  Future<StorageDto> addStorage(StorageDto dto);
}
