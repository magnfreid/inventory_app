import 'package:part_remote_data_source/part_remote_data_source.dart';
import 'package:part_repository/part_repository.dart';

class PartRepository {
  PartRepository({required PartRemoteDataSource remote}) : _remote = remote;

  final PartRemoteDataSource _remote;

  Stream<List<Part>> watchParts() {
    return _remote.watchParts().map(
      (dtos) => dtos.map(Part.fromDto).toList(),
    );
  }

  Future<Part> addPart(PartCreateModel createModel) async {
    final dto = PartDto(
      id: '',
      name: createModel.name,
      detailNumber: createModel.detailNumber,
      isRecycled: createModel.isRecycled,
      price: createModel.price,
      brand: createModel.brand,
      description: createModel.description,
    );

    final createdDto = await _remote.addPart(dto);
    return Part.fromDto(createdDto);
  }
}
