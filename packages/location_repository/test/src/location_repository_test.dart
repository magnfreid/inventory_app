// Not required for test files

import 'package:flutter_test/flutter_test.dart';
import 'package:location_repository/location_repository.dart';

void main() {
  group('LocationRepository', () {
    test('interface is defined', () {
      expect(LocationRepository, isNotNull);
    });
  });
}
