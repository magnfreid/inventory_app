import 'package:part_remote_data_source/src/models/part_dto.dart';

abstract interface class PartRemoteDataSource {
  Stream<List<PartDto>> watchParts();
  Future<PartDto> addPart(PartDto part);
}
