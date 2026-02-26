// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import '../../lib/user_remote.dart';

void main() {
  group('UserRemoteDataSource', () {
    test('can be instantiated', () {
      expect(UserRemote(), isNotNull);
    });
  });
}
