import 'package:part_remote/part_remote.dart';

abstract interface class PartRemote {
  Stream<List<PartDto>> watchParts();
  Future<PartDto> addPart(PartCreateDto partCreateDto);
  Future<void> editPart(PartDto updatedPart);
}
