import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late FirebaseAuthRepository repository;

  setUp(() {
    final mockFirebaseAuth = MockFirebaseAuth();
    repository = FirebaseAuthRepository(firebaseAuth: mockFirebaseAuth);
  });

  test('can be instantiated', () {
    expect(repository, isNotNull);
  });
}
