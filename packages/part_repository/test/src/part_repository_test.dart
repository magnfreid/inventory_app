// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:part_repository/part_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PartRepository', () {
    test('can be instantiated', () {
      expect(PartRepository(), isNotNull);
    });
  });
}
