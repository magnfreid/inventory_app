import 'package:part_remote/part_remote.dart';
import 'package:part_repository/part_repository.dart';

class PartRepository {
  PartRepository({required PartRemote remote}) : _remote = remote;

  final PartRemote _remote;

  Stream<List<Part>> watchParts() {
    return _remote.watchParts().map(
      (dtos) => dtos.map(Part.fromDto).toList(),
    );
  }

  Future<Part> addPart(Part part) async {
    final dtoWithId = await _remote.addPart(part.toDto());
    return Part.fromDto(dtoWithId);
  }

  Future<void> editPart(Part part) async {
    await _remote.editPart(part.toDto());
  }
}
