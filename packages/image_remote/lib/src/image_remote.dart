import 'dart:io';

/// Abstract interface for image storage.
abstract interface class ImageRemote {
  Future<String> uploadImage({
    required String partId,
    required File file,
  });

  Future<void> deleteImage({
    required String fileName,
  });

  Future<String> getImageUrl({
    required String fileName,
  });
}
