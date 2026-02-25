// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:storage_repository/storage_repository.dart';
import 'package:test/test.dart';

void main() {
  group('StorageRepository', () {
    test('can be instantiated', () {
      expect(StorageRepository(), isNotNull);
    });
  });
}
