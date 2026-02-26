// Not required for test files
import 'package:firebase_user_remote/firebase_user_remote.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseUserRemoteDataSource', () {
    test('can be instantiated', () {
      expect(FirebaseUserRemoteDataSource(), isNotNull);
    });
  });
}
