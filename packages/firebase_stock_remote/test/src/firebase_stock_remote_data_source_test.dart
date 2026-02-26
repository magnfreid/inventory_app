// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_stock_remote/firebase_stock_remote.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseStockRemoteDataSource', () {
    test('can be instantiated', () {
      expect(FirebaseStockRemoteDataSource(), isNotNull);
    });
  });
}
