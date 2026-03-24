import 'dart:typed_data';

/// Abstract interface for image storage.
abstract interface class ImageRemote {
  /// Uploads [data] (bytes) to the path `{orgId}/{fileName}` in Firebase Storage.
  /// Returns the public download URL if successful.
  Future<String> uploadImage({
    required String orgId,
    required String fileName,
    required Uint8List data,
    String? contentType,
  });

  /// Deletes the image at `{orgId}/{fileName}`.
  Future<void> deleteImage({
    required String orgId,
    required String fileName,
  });

  /// Returns a download URL for the image at `{orgId}/{fileName}`.
  Future<String> getImageUrl({
    required String orgId,
    required String fileName,
  });
}
