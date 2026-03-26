import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_remote/image_remote.dart';
import 'package:path_provider/path_provider.dart';

/// Repository responsible for image upload and deletion.
///
/// Handles resizing to 1080x608 (9:16), JPEG compression (85% quality),
/// and delegates storage operations to [ImageRemote].
class ImageRepository {
  /// Creates an [ImageRepository] with the given remote data source.
  ImageRepository({required ImageRemote remote}) : _remote = remote;

  final ImageRemote _remote;

  /// Uploads an image after resizing and compressing it.
  ///
  /// - Resizes image to 1080x608 using cubic interpolation.
  /// - Encodes as JPEG with 85% quality.
  /// - Saves to temporary directory before upload.
  ///
  /// [partId] Unique identifier for the part.
  /// [deviceImgPath] Local file path of the image on device.
  ///
  /// Returns the download URL of the uploaded image.
  ///
  /// Throws [Exception] if file is not found or cannot be decoded.
  Future<String> uploadImage({
    required String partId,
    required String deviceImgPath,
  }) async {
    final file = File(deviceImgPath);
    if (!file.existsSync()) {
      throw Exception('File not found at $deviceImgPath');
    }

    final imageBytes = await file.readAsBytes();
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    const targetWidth = 1080;
    final targetHeight = (1080 * 9 / 16).round();

    final resized = img.copyResize(
      image,
      width: targetWidth,
      height: targetHeight,
      interpolation: img.Interpolation.cubic,
    );

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/$partId.jpg');

    await tempFile.writeAsBytes(img.encodeJpg(resized, quality: 85));

    final downloadUrl = await _remote.uploadImage(
      partId: partId,
      file: tempFile,
    );

    return downloadUrl;
  }

  /// Deletes an image by its part ID.
  Future<void> deleteImage({required String partId}) =>
      _remote.deleteImage(partId: partId);
}
