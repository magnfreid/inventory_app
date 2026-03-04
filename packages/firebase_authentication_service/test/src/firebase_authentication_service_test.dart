import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_service/firebase_authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockAuth;
  late FirebaseAuthenticationService service;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    service = FirebaseAuthenticationService(firebaseAuth: mockAuth);
  });

  test('currentUser emits AuthenticatedUser when signed in', () async {
    final fakeUser = MockUser();
    when(() => fakeUser.uid).thenReturn('abc123');

    when(
      () => mockAuth.authStateChanges(),
    ).thenAnswer((_) => Stream.value(fakeUser));

    final result = await service.currentUser.first;
    expect(result?.id, 'abc123');
  });

  test('currentUser emits null when signed out', () async {
    when(
      () => mockAuth.authStateChanges(),
    ).thenAnswer((_) => Stream.value(null));

    final result = await service.currentUser.first;
    expect(result, null);
  });

  test('signInWithEmailAndPassword calls FirebaseAuth', () async {
    when(
      () => mockAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password123',
      ),
    ).thenAnswer((_) async => MockUserCredential());

    await service.signInWithEmailAndPassword(
      email: 'test@test.com',
      password: 'password123',
    );

    verify(
      () => mockAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password123',
      ),
    ).called(1);
  });

  test('signOut calls FirebaseAuth.signOut', () async {
    when(() => mockAuth.signOut()).thenAnswer((_) async {});

    await service.signOut();

    verify(() => mockAuth.signOut()).called(1);
  });
}
