import 'package:part_remote/part_remote.dart';

///Interface for [PartDto] remote data source.
abstract interface class PartRemote {
  ///Returns a stream of a list of [PartDto]
  Stream<List<PartDto>> watchParts();

  ///Adds a new [PartDto] to the remote data source.
  Future<PartDto> addPart(PartDto dto);

  ///Edits an existing [PartDto] on the remote data source.
  Future<PartDto> editPart(PartDto dto);
}
