// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:location_repository/location_repository.dart';

void main() {
  group('LocationRepository', () {
    test('can be instantiated', () {
      expect(LocationRepository(), isNotNull);
    });
  });
}
