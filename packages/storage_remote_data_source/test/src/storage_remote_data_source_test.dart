// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:storage_remote_data_source/storage_remote_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('StorageRemoteDataSource', () {
    test('can be instantiated', () {
      expect(StorageRemoteDataSource(), isNotNull);
    });
  });
}
