// Not required for test files
import 'package:firebase_location_repository/firebase_location_repository.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseLocationRepository', () {
    test('can be instantiated', () {
      expect(FirebaseLocationRepository(), isNotNull);
    });
  });
}
