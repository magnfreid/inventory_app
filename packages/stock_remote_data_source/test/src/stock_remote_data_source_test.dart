// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:stock_remote_data_source/stock_remote_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('StockRemoteDataSource', () {
    test('can be instantiated', () {
      expect(StockRemoteDataSource(), isNotNull);
    });
  });
}
