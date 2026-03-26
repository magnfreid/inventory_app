import 'dart:io';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_remote/image_remote.dart';

/// Firebase implementation of [ImageRemote].
class FirebaseImageRemote implements ImageRemote {
  /// Creates a [FirebaseImageRemote] implementation of [ImageRemote]. Optional
  /// [FirebaseStorage] used for testing.
  FirebaseImageRemote({
    required String organizationId,
    FirebaseStorage? storage,
  }) : _storage = storage ?? FirebaseStorage.instance,
       _organizationId = organizationId;

  final FirebaseStorage _storage;
  final String _organizationId;

  @override
  Future<String> uploadImage({
    required String partId,
    required File file,
  }) async {
    {
      try {
        final ref = _storage.ref(
          'organizations/$_organizationId/parts/$partId.jpg',
        );
        await ref.putFile(
          file,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        final downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } on FirebaseException catch (e) {
        throw mapFirebaseException(e);
      }
    }
  }

  @override
  Future<void> deleteImage({required String partId}) async {
    if (partId.isEmpty) return;
    try {
      final ref = _storage.ref(
        'organizations/$_organizationId/parts/$partId.jpg',
      );
      await ref.delete();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}
