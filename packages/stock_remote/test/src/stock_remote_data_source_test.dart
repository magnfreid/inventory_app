// Not required for test files
// ignore_for_file: prefer_const_constructors
import '../../lib/stock_remote.dart';
import 'package:test/test.dart';

void main() {
  group('StockRemoteDataSource', () {
    test('can be instantiated', () {
      expect(StockRemote(), isNotNull);
    });
  });
}
