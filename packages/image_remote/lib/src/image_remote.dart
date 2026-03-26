import 'dart:io';

/// Interface for remote image storage operations.
abstract interface class ImageRemote {
  /// Uploads an image file to remote storage and returns its URL.
  ///
  /// The image is associated with the specified [partId].
  ///
  /// - [partId]: Unique identifier for the part the image belongs to.
  /// - [file]: The image file to upload.
  ///
  /// Returns the URL of the uploaded image.
  ///
  /// Throws an exception if the upload fails.
  Future<String> uploadImage({
    required String partId,
    required File file,
  });

  /// Deletes an image from remote storage.
  ///
  /// - [partId]: Unique identifier of the image to delete.
  ///
  /// Throws an exception if the deletion fails.
  Future<void> deleteImage({
    required String partId,
  });
}
