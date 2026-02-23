import 'package:location_repository/src/models/location.dart';
import 'package:location_repository/src/models/location_create_model.dart';

abstract interface class LocationRepository {
  Stream<List<Location>> watchLocations();
  Future<Location> add({required LocationCreateModel locationCreateModel});
}
