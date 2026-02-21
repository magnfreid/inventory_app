import 'package:location_repository/src/models/location.dart';

abstract interface class LocationRepository {
  Stream<List<Location>> watchLocations();
}
