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

  Future<Part> addPart(PartCreate createModel) async {
    final createDto = createModel.toCreateDto();
    final dto = await _remote.addPart(createDto);
    return Part.fromDto(dto);
  }

  Future<void> editPart(Part updatedPart) async {
    await _remote.editPart(updatedPart.toDto());
  }
}
