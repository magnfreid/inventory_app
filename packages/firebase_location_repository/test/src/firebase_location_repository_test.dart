// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_location_repository/firebase_location_repository.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseLocationRepository', () {
    test('can be instantiated', () {
      expect(FirebaseLocationRepository(), isNotNull);
    });
  });
}
