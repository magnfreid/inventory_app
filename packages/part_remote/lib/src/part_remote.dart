import 'package:part_remote/part_remote.dart';

abstract interface class PartRemote {
  Stream<List<PartDto>> watchParts();
  Future<PartDto> addPart(PartDto dto);
  Future<void> editPart(PartDto dto);
}
