import 'package:part_repository/src/models/part.dart';
import 'package:part_repository/src/models/part_create_model.dart';

abstract interface class PartRepository {
  Stream<List<Part>> watchProducts();
  Future<Part> addPart(PartCreateModel partCreateModel);
}
