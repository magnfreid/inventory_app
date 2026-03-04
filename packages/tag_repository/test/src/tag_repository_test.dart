// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:tag_repository/tag_repository.dart';
import 'package:test/test.dart';

void main() {
  group('TagRepository', () {
    test('can be instantiated', () {
      expect(TagRepository(), isNotNull);
    });
  });
}
