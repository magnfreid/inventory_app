import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_remote/image_remote.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepository {
  ImageRepository({required ImageRemote remote}) : _remote = remote;

  final ImageRemote _remote;

  Future<String> uploadImage({
    required String partId,
    required String deviceImgPath,
  }) async {
    // Step 1: Read file from device
    final file = File(deviceImgPath);
    if (!file.existsSync()) {
      log('File not found at $deviceImgPath');
      throw Exception('File not found at $deviceImgPath');
    }
    log('File -> $file');

    // Step 2: Decode image
    final imageBytes = await file.readAsBytes();
    // log('ImageBytes -> $imageBytes');
    final image = img.decodeImage(imageBytes);
    log('Image -> $image');
    if (image == null) throw Exception('Failed to decode image');

    // Step 3: Resize (16:9, width = 1080)
    const targetWidth = 1080;
    final targetHeight = (1080 * 9 / 16).round();

    final resized = img.copyResize(
      image,
      width: targetWidth,
      height: targetHeight,
      interpolation: img.Interpolation.cubic,
    );
    log('Resized -> $resized');

    // Step 4: Write resized image to temporary file
    final tempDir = await getTemporaryDirectory();
    log('TempDir -> $tempDir');

    final tempFile = File('${tempDir.path}/$partId.jpg');
    log('TempFile -> $tempFile');

    await tempFile.writeAsBytes(img.encodeJpg(resized, quality: 85));

    final sizeInBytes = await tempFile.length();
    final sizeInMB = sizeInBytes / (1024 * 1024);

    log('Temp file size: ${sizeInMB.toStringAsFixed(2)} MB');

    // Step 5: Upload via remote
    final downloadUrl = await _remote.uploadImage(
      partId: partId,
      file: tempFile,
    );
    log('DownloadUrl -> $downloadUrl');

    return downloadUrl;
  }

  Future<void> deleteImage({required String fileName}) =>
      _remote.deleteImage(fileName: fileName);

  Future<String> getImageUrl({
    required String fileName,
  }) => _remote.getImageUrl(fileName: fileName);
}
