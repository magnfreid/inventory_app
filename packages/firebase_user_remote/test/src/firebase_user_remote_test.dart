import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_user_remote/firebase_user_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_remote/user_remote.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late UserRemote remote;
  late UserDto user;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    remote = FirebaseUserRemote(firestore: firestore);
    user = UserDto(
      id: '123',
      organizationId: 'org1',
      name: 'Username',
      email: 'test@test.com',
      role: .admin,
    );
  });

  group('FirebaseUserRemoteDataSource', () {
    test('watchUser emits the correct UserDto', () async {
      await firestore.collection('users').doc('123').set(user.toJson());

      await expectLater(
        remote.watchUser('123'),
        emits(
          isA<UserDto>()
              .having((u) => u.id, 'id', '123')
              .having((u) => u.name, 'name', 'Username')
              .having((u) => u.email, 'email', 'test@test.com')
              .having((u) => u.organizationId, 'organizationId', 'org1')
              .having((u) => u.role, 'role', isA<UserDtoRole>()),
        ),
      );
    });

    test('watchUser emits null if user does not exist', () async {
      await expectLater(
        remote.watchUser('nonexistent'),
        emits(null),
      );
    });

    test(
      'watchUsers emits list of users for the correct organization',
      () async {
        final otherUser = UserDto(
          id: '456',
          organizationId: 'org2',
          name: 'Other',
          email: 'other@test.com',
          role: .user,
        );

        await firestore.collection('users').doc('123').set(user.toJson());
        await firestore.collection('users').doc('456').set(otherUser.toJson());

        await expectLater(
          remote.watchUsers('org1'),
          emits(
            isA<List<UserDto>>()
                .having((list) => list.length, 'length', 1)
                .having((list) => list.first.id, 'first id', '123'),
          ),
        );

        await expectLater(
          remote.watchUsers('org2'),
          emits(
            isA<List<UserDto>>()
                .having((list) => list.length, 'length', 1)
                .having((list) => list.first.id, 'first id', '456'),
          ),
        );
      },
    );

    test('watchUsers emits empty list if no users in org', () async {
      await expectLater(
        remote.watchUsers('nonexistentOrg'),
        emits(
          isA<List<UserDto>>().having((list) => list.isEmpty, 'is empty', true),
        ),
      );
    });
  });
}
