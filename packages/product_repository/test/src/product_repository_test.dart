// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:product_repository/product_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ProductRepository', () {
    test('can be instantiated', () {
      expect(ProductRepository(), isNotNull);
    });
  });
}
