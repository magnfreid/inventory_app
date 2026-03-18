import 'package:core_remote/core_remote.dart';
import 'package:part_remote/part_remote.dart';
import 'package:part_repository/part_repository.dart';
import 'package:part_repository/src/exceptions/part_exceptions.dart';
import 'package:part_repository/src/exceptions/remote_exceptions_mapper.dart';

/// Repository responsible for fetching, adding, and editing [Part] domain
///  models.
/// Wraps a [PartRemote] data source and maps [PartDto]s to [Part]s.
class PartRepository {
  /// Creates a [PartRepository] using the provided [remote] data source.
  PartRepository({required PartRemote remote}) : _remote = remote;

  final PartRemote _remote;

  /// Returns a [Stream] of all [Part]s.
  ///
  /// Maps the [PartDto]s from [_remote] to [Part] domain models.
  Stream<List<Part>> watchParts() {
    return _remote
        .watchParts()
        .map(
          (dtos) => dtos.map(Part.fromDto).toList(),
        )
        //
        // ignore: inference_failure_on_untyped_parameter
        .handleError((e) {
          if (e is RemoteException) {
            throw mapRemoteToRepositoryException(e);
          } else {
            throw const PartUnknownError('Unknown error');
          }
        });
  }

  /// Adds a new [part] via [_remote] and returns the created [Part] with its
  /// assigned id.
  Future<Part> addPart(Part part) async {
    try {
      final dtoWithId = await _remote.addPart(part.toDto());
      return Part.fromDto(dtoWithId);
    } on RemoteException catch (e) {
      throw mapRemoteToRepositoryException(e);
    } on Exception catch (_) {
      throw const UnknownRemoteException('Unknown error');
    }
  }

  /// Updates an existing [part] via [_remote].
  ///
  /// Converts the [Part] to a [PartDto] before sending it to the remote.
  Future<Part> editPart(Part part) async {
    try {
      await _remote.editPart(part.toDto());
      return part;
    } on RemoteException catch (e) {
      throw mapRemoteToRepositoryException(e);
    } on Exception catch (_) {
      throw const UnknownRemoteException('Unknown error');
    }
  }

  /// Deletes an existing [PartDto] via [_remote]
  Future<void> deletePart(String partId) async {
    try {
      await _remote.deletePart(partId);
    } on RemoteException catch (e) {
      throw mapRemoteToRepositoryException(e);
    } on Exception catch (_) {
      throw const UnknownRemoteException('Unknown error');
    }
  }
}
