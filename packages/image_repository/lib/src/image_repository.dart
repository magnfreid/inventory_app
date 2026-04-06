import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_remote/image_remote.dart';
import 'package:path_provider/path_provider.dart';

typedef UploadedImagePaths = ({String imgPath, String thumbnailPath});

/// Repository responsible for image upload and deletion.
///
/// Handles uploading both a full-size image and a thumbnail, then delegates
/// storage operations to [ImageRemote].
class ImageRepository {
  /// Creates an [ImageRepository] with the given remote data source.
  ImageRepository({required ImageRemote remote}) : _remote = remote;

  final ImageRemote _remote;

  /// Uploads a full-size image and a thumbnail.
  ///
  /// [partId] Unique identifier for the part.
  /// [bytes] Full-size image bytes.
  /// [thumbnailBytes] Thumbnail image bytes.
  ///
  /// Returns a record with the download URLs for both.
  Future<UploadedImagePaths> uploadImage({
    required String partId,
    required Uint8List bytes,
    required Uint8List thumbnailBytes,
  }) async {
    if (kIsWeb) {
      final imgPath = await _remote.uploadImageFromBytes(
        partId: partId,
        bytes: bytes,
      );
      final thumbnailPath = await _remote.uploadThumbnailFromBytes(
        partId: partId,
        bytes: thumbnailBytes,
      );
      return (imgPath: imgPath, thumbnailPath: thumbnailPath);
    } else {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$partId.jpg');
      await tempFile.writeAsBytes(bytes);

      final imgPath = await _remote.uploadImageFromFile(
        partId: partId,
        file: tempFile,
      );
      final thumbnailPath = await _remote.uploadThumbnailFromBytes(
        partId: partId,
        bytes: thumbnailBytes,
      );
      return (imgPath: imgPath, thumbnailPath: thumbnailPath);
    }
  }

  /// Deletes both the image and thumbnail for a given part.
  Future<void> deleteImage({required String partId}) async {
    await Future.wait([
      _remote.deleteImage(partId: partId),
      _remote.deleteThumbnail(partId: partId),
    ]);
  }
}
