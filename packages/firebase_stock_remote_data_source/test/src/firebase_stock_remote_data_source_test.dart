// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_stock_remote_data_source/firebase_stock_remote_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseStockRemoteDataSource', () {
    test('can be instantiated', () {
      expect(FirebaseStockRemoteDataSource(), isNotNull);
    });
  });
}
