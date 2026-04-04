import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_image_remote/firebase_image_remote.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockReference extends Mock implements Reference {}

class MockTaskSnapshot extends Mock implements TaskSnapshot {}

/// A fake [UploadTask] that completes immediately with a given [TaskSnapshot].
class FakeUploadTask implements UploadTask {
  FakeUploadTask(this._snapshot);

  final TaskSnapshot _snapshot;

  @override
  Future<R> then<R>(
    FutureOr<R> Function(TaskSnapshot value) onValue, {
    Function? onError,
  }) =>
      Future.value(_snapshot).then(onValue, onError: onError);

  @override
  Future<TaskSnapshot> catchError(
    Function onError, {
    bool Function(Object error)? test,
  }) =>
      Future.value(_snapshot).catchError(onError, test: test);

  @override
  Stream<TaskSnapshot> asStream() => Stream.value(_snapshot);

  @override
  Future<TaskSnapshot> whenComplete(FutureOr<void> Function() action) =>
      Future.value(_snapshot).whenComplete(action);

  @override
  Future<TaskSnapshot> timeout(
    Duration timeLimit, {
    FutureOr<TaskSnapshot> Function()? onTimeout,
  }) =>
      Future.value(_snapshot).timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<bool> cancel() => Future.value(false);

  @override
  Future<bool> pause() => Future.value(false);

  @override
  Future<bool> resume() => Future.value(false);

  @override
  Stream<TaskSnapshot> get snapshotEvents => Stream.value(_snapshot);

  @override
  TaskSnapshot get snapshot => _snapshot;

  @override
  FirebaseStorage get storage => throw UnimplementedError();
}

void main() {
  late MockFirebaseStorage mockStorage;
  late MockReference mockRef;
  late FirebaseImageRemote imageRemote;

  final file = File('does-not-matter.jpg');
  const organizationId = 'org123';
  const partId = 'part456';
  const downloadUrl = 'https://fake.url/image.jpg';

  setUpAll(() {
    registerFallbackValue(File('fake.jpg'));
    registerFallbackValue(SettableMetadata());
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockStorage = MockFirebaseStorage();
    mockRef = MockReference();
    imageRemote = FirebaseImageRemote(
      organizationId: organizationId,
      storage: mockStorage,
    );

    when(() => mockStorage.ref(any())).thenReturn(mockRef);

    final snapshot = MockTaskSnapshot();
    when(
      () => mockRef.putFile(any(), any()),
    ).thenAnswer((_) => FakeUploadTask(snapshot));

    when(
      () => mockRef.putData(any(), any()),
    ).thenAnswer((_) => FakeUploadTask(snapshot));

    when(
      () => mockRef.getDownloadURL(),
    ).thenAnswer((_) => Future.value(downloadUrl));

    when(() => mockRef.delete()).thenAnswer((_) async {});
  });

  group(
    'FirebaseImageRemote',
    () {
      group('uploadImageFromFile', () {
        test('uploads file and returns download URL', () async {
          final result = await imageRemote.uploadImageFromFile(
            partId: partId,
            file: file,
          );

          expect(result, downloadUrl);
          verify(() => mockRef.putFile(file, any())).called(1);
          verify(() => mockRef.getDownloadURL()).called(1);
        });

        test('uses correct storage path', () async {
          await imageRemote.uploadImageFromFile(partId: partId, file: file);
          verify(
            () => mockStorage.ref(
              'organizations/$organizationId/parts/$partId.jpg',
            ),
          ).called(1);
        });

        test('throws RemoteException on FirebaseException', () async {
          when(
            () => mockRef.putFile(any(), any()),
          ).thenThrow(FirebaseException(plugin: 'storage', code: ''));
          expect(
            () async =>
                imageRemote.uploadImageFromFile(partId: partId, file: file),
            throwsA(isA<RemoteException>()),
          );
        });
      });

      group('uploadImageFromBytes', () {
        final bytes = Uint8List.fromList([1, 2, 3]);

        test('uploads bytes and returns download URL', () async {
          final result = await imageRemote.uploadImageFromBytes(
            partId: partId,
            bytes: bytes,
          );

          expect(result, downloadUrl);
          verify(() => mockRef.putData(bytes, any())).called(1);
          verify(() => mockRef.getDownloadURL()).called(1);
        });

        test('uses correct storage path', () async {
          await imageRemote.uploadImageFromBytes(partId: partId, bytes: bytes);
          verify(
            () => mockStorage.ref(
              'organizations/$organizationId/parts/$partId.jpg',
            ),
          ).called(1);
        });
      });

      group('deleteImage', () {
        test('deletes the correct reference', () async {
          await imageRemote.deleteImage(partId: partId);
          verify(() => mockRef.delete()).called(1);
        });

        test('does nothing for empty partId', () async {
          await imageRemote.deleteImage(partId: '');
          verifyNever(() => mockRef.delete());
        });

        test('throws RemoteException on FirebaseException', () async {
          when(
            () => mockRef.delete(),
          ).thenThrow(FirebaseException(plugin: 'storage', code: ''));
          expect(
            () async => imageRemote.deleteImage(partId: partId),
            throwsA(isA<RemoteException>()),
          );
        });
      });
    },
  );
}
