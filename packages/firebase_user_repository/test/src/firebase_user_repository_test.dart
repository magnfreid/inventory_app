// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:firebase_user_repository/firebase_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseUserRepository', () {
    test('can be instantiated', () {
      expect(FirebaseUserRepository(), isNotNull);
    });
  });
}
