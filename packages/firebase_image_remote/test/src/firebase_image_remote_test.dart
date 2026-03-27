import 'dart:io';

import 'package:firebase_image_remote/firebase_image_remote.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockReference extends Mock implements Reference {}

class MockUploadTask extends Mock implements UploadTask {}

class MockTaskSnapshot extends Mock implements TaskSnapshot {}

void main() {
  late MockFirebaseStorage mockStorage;
  late MockReference mockRef;
  late MockUploadTask mockUploadTask;
  late FirebaseImageRemote imageRemote;

  final file = File('does-not-matter.jpg');
  const organizationId = 'org123';
  const partId = 'part456';
  const downloadUrl = 'https://fake.url/image.jpg';

  setUpAll(() {
    registerFallbackValue(File('fake.jpg'));
    registerFallbackValue(SettableMetadata());
  });

  setUp(() {
    mockStorage = MockFirebaseStorage();
    mockRef = MockReference();
    mockUploadTask = MockUploadTask();
    imageRemote = FirebaseImageRemote(
      organizationId: organizationId,
      storage: mockStorage,
    );

    // Always stub ref lookup
    when(() => mockStorage.ref(any())).thenReturn(mockRef);

    // putFile returns UploadTask synchronously
    when(() => mockRef.putFile(any(), any())).thenAnswer((_) => mockUploadTask);

    // whenComplete returns Future<TaskSnapshot>
    final snapshot = MockTaskSnapshot();
    when(
      () => mockUploadTask.whenComplete(any()),
    ).thenAnswer((invocation) => Future.value(snapshot));

    // getDownloadURL returns Future<String>
    when(
      () => mockRef.getDownloadURL(),
    ).thenAnswer((_) => Future.value(downloadUrl));

    // delete returns Future<void>
    when(() => mockRef.delete()).thenAnswer((_) async {});
  });

  group(
    'FirebaseImageRemote',
    () {
      // test('uploadImage uploads file and returns download URL', () async {
      //   final result = await imageRemote.uploadImage(
      //     partId: partId,
      //     file: file,
      //   );

      //   await expectLater(result, downloadUrl);

      //   verify(() => mockRef.putFile(file, any())).called(1);
      //   verify(() => mockRef.getDownloadURL()).called(1);
      // });

      // test('deleteImage deletes the correct reference', () async {
      //   await imageRemote.deleteImage(partId: partId);
      //   verify(() => mockRef.delete()).called(1);
      // });

      // test('deleteImage does nothing for empty partId', () async {
      //   await imageRemote.deleteImage(partId: '');
      //   verifyNever(() => mockRef.delete());
      // });

      test(
        'uploadImage throws exception',
        () async {
          when(
            () => mockRef.putFile(any(), any()),
          ).thenThrow(FirebaseException(plugin: 'storage', code: ''));
          expect(
            () async => imageRemote.uploadImage(partId: partId, file: file),
            throwsA(isA<RemoteException>()),
          );
        },
      );

      test('deleteImage throws exception', () async {
        when(
          () => mockRef.delete(),
        ).thenThrow(FirebaseException(plugin: 'storage', code: ''));
        expect(
          () async => imageRemote.deleteImage(partId: partId),
          throwsA(isA<RemoteException>()),
        );
      });
    },
  );
}
