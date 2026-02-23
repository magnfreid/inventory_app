// Not required for test files
import 'package:firebase_product_repository/firebase_product_repository.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseProductRepository', () {
    test('can be instantiated', () {
      expect(FirebaseProductRepository(), isNotNull);
    });
  });
}
