// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:authentication_service/authentication_service.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationService', () {
    test('can be instantiated', () {
      expect(AuthenticationService(), isNotNull);
    });
  });
}
