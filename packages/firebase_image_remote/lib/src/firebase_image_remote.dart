import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_remote/image_remote.dart';

/// Firebase implementation of [ImageRemote].
class FirebaseImageRemote implements ImageRemote {
  /// Creates a [FirebaseImageRemote] implementation of [ImageRemote]. Optional
  /// [FirebaseStorage] used for testing.
  FirebaseImageRemote({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  @override
  Future<String> uploadImage({
    required String orgId,
    required String fileName,
    required Uint8List data,
    String? contentType,
  }) async {
    final ref = _storage.ref().child('organizations/$orgId/$fileName');
    final metadata = SettableMetadata(contentType: contentType);
    await ref.putData(data, metadata);
    return ref.getDownloadURL();
  }

  @override
  Future<void> deleteImage({
    required String orgId,
    required String fileName,
  }) async {
    final ref = _storage.ref().child('organizations/$orgId/$fileName');
    await ref.delete();
  }

  @override
  Future<String> getImageUrl({
    required String orgId,
    required String fileName,
  }) async {
    final ref = _storage.ref().child('organizations/$orgId/$fileName');
    return ref.getDownloadURL();
  }
}
