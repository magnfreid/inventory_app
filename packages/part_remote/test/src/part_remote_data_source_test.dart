// Not required for test files
// ignore_for_file: prefer_const_constructors
import '../../lib/part_remote.dart';
import 'package:test/test.dart';

void main() {
  group('PartRemoteDataSource', () {
    test('can be instantiated', () {
      expect(PartRemote(), isNotNull);
    });
  });
}
