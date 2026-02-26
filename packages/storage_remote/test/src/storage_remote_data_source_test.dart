// Not required for test files
// ignore_for_file: prefer_const_constructors
import '../../lib/storage_remote.dart';
import 'package:test/test.dart';

void main() {
  group('StorageRemoteDataSource', () {
    test('can be instantiated', () {
      expect(StorageRemote(), isNotNull);
    });
  });
}
