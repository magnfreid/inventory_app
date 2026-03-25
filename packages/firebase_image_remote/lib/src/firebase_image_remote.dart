import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_remote/image_remote.dart';

//TODO(magnfreid): Error handling for file!

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
      log('orgId -> $_organizationId');
      final ref = _storage.ref(
        'organizations/$_organizationId/parts/$partId.jpg',
      );
      log('ref -> $ref');
      await ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    }
  }

  @override
  Future<void> deleteImage({
    required String fileName,
  }) async {
    final ref = _storage.ref().child(
      'organizations/$_organizationId/$fileName',
    );
    await ref.delete();
  }

  @override
  Future<String> getImageUrl({
    required String fileName,
  }) async {
    final ref = _storage.ref().child(
      'organizations/$_organizationId/$fileName',
    );
    return ref.getDownloadURL();
  }
}
