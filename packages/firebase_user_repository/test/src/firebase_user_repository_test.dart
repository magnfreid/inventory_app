import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_repository/firebase_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseUserRepository repository;

  setUp(() {
    final mockFirebaseFirestore = MockFirebaseFirestore();
    repository = FirebaseUserRepository(firestore: mockFirebaseFirestore);
  });

  test('can be instantiated', () {
    expect(repository, isNotNull);
  });
}
