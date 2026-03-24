import 'dart:typed_data';

/// Abstract interface for image storage.
abstract interface class ImageRemote {
  Future<String> uploadImage({
    required String orgId,
    required String fileName,
    required Uint8List data,
    String? contentType,
  });

  Future<void> deleteImage({
    required String orgId,
    required String fileName,
  });

  Future<String> getImageUrl({
    required String orgId,
    required String fileName,
  });
}
