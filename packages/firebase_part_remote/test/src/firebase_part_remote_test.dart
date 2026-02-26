// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_part_remote/firebase_part_remote.dart';
import 'package:test/test.dart';

void main() {
  group('FirebasePartRemoteDataSource', () {
    test('can be instantiated', () {
      expect(FirebasePartRemoteDataSource(), isNotNull);
    });
  });
}
