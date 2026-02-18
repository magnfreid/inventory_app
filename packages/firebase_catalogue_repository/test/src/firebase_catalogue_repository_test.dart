// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_catalogue_repository/firebase_catalogue_repository.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseCatalogueRepository', () {
    test('can be instantiated', () {
      expect(FirebaseCatalogueRepository(), isNotNull);
    });
  });
}
