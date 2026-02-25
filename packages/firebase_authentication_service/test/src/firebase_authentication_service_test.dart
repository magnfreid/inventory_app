// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:firebase_authentication_service/firebase_authentication_service.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseAuthenticationService', () {
    test('can be instantiated', () {
      expect(FirebaseAuthenticationService(), isNotNull);
    });
  });
}
