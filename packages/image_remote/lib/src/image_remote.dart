import 'dart:io';
import 'dart:typed_data';

/// Interface for remote image storage operations.
abstract interface class ImageRemote {
  /// Uploads an image file to remote storage and returns its URL.
  Future<String> uploadImageFromFile({
    required String partId,
    required File file,
  });

  /// Uploads an image from bytes to remote storage and returns its URL.
  Future<String> uploadImageFromBytes({
    required String partId,
    required Uint8List bytes,
  });

  /// Uploads a thumbnail from bytes to remote storage and returns its URL.
  Future<String> uploadThumbnailFromBytes({
    required String partId,
    required Uint8List bytes,
  });

  /// Deletes an image from remote storage.
  Future<void> deleteImage({required String partId});

  /// Deletes a thumbnail from remote storage.
  Future<void> deleteThumbnail({required String partId});
}
