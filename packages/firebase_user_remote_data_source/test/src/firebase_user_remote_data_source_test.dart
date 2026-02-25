// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_user_remote_data_source/firebase_user_remote_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseUserRemoteDataSource', () {
    test('can be instantiated', () {
      expect(FirebaseUserRemoteDataSource(), isNotNull);
    });
  });
}
