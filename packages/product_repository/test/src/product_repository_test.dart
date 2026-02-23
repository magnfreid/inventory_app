// Not required for test files
import 'package:product_repository/product_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ProductRepository', () {
    test('interface is defined', () {
      expect(ProductRepository, isNotNull);
    });
  });
}
