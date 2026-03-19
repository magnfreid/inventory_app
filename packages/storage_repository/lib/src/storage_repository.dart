import 'package:core_remote/core_remote.dart';
import 'package:storage_remote/storage_remote.dart';
import 'package:storage_repository/storage_repository.dart';

/// Repository for fetching and managing [Storage]s via a [StorageRemote].
class StorageRepository {
  /// Creates a [StorageRepository] with the given [remote] data source.
  StorageRepository({
    required StorageRemote remote,
  }) : _remote = remote;

  final StorageRemote _remote;

  //TODO(magnfreid): Add watchReplay!

  /// Watches all storages from the remote source.
  ///
  /// Returns a stream of [Storage] domain models.
  Stream<List<Storage>> watchStorages() {
    return _remote
        .watchStorages()
        .map(
          (dtos) => dtos.map(Storage.fromDto).toList(),
        )
        //
        // ignore: inference_failure_on_untyped_parameter
        .handleError((e) {
          if (e is RemoteException) {
            throw e;
          } else {
            throw const UnknownRemoteException();
          }
        });
  }

  /// Adds a new storage using the [storage].
  ///
  /// Converts the model to a [StorageDto] and sends it to the remote.
  /// Returns the created [Storage] domain model with its assigned ID.
  Future<Storage> addStorage({
    required Storage storage,
  }) async {
    final dto = StorageDto(
      id: storage.id,
      name: storage.name,
      description: storage.description,
    );
    try {
      final createdDto = await _remote.addStorage(dto);
      return Storage.fromDto(createdDto);
    } on RemoteException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }

  /// Edits and existing [Storage] using the [storage]
  ///
  /// Converts the model to a [StorageDto] and sends it to the remote.
  /// Returns the edited [Storage] domain model with its updated values.
  Future<Storage> editStorage({required Storage storage}) async {
    final dto = storage.toDto();
    try {
      final result = await _remote.editStorage(dto);
      return Storage.fromDto(result);
    } on RemoteException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }
}
