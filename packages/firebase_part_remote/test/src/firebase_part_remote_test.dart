// Not required for test files
import 'package:firebase_part_remote/firebase_part_remote.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class FirebasePartRemoteMock extends Mock implements FirebasePartRemote {}

void main() {
  group('FirebasePartRemote', () {
    test('can be instantiated', () {
      expect(FirebasePartRemote(), isNotNull);
    });
  });
}
