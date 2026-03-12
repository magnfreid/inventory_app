import 'package:storage_remote/storage_remote.dart';

///Interface for [StorageDto] remote data source.
abstract interface class StorageRemote {
  ///Return a [Stream] of a [List] of [StorageDto].
  Stream<List<StorageDto>> watchStorages();

  ///Adds a new [StorageDto] to the remote database.
  Future<StorageDto> addStorage(StorageDto dto);

  ///Edits an existing [StorageDto] on the remote.
  Future<StorageDto> editStorage(StorageDto updatedStorage);
}
