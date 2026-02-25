import 'package:storage_repository/src/models/storage.dart';
import 'package:storage_repository/src/models/storage_create_model.dart';

abstract interface class StorageRepository {
  Stream<List<Storage>> watchStorages();
  Future<Storage> add({required StorageCreateModel storageCreateModel});
}
