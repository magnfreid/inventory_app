// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:stock_repository/stock_repository.dart';
import 'package:test/test.dart';

void main() {
  group('StockRepository', () {
    test('can be instantiated', () {
      expect(StockRepository(), isNotNull);
    });
  });
}
