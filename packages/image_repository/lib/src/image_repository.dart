import 'dart:typed_data';
import 'package:image_remote/image_remote.dart';

class ImageRepository {
  ImageRepository({required ImageRemote remote}) : _remote = remote;

  final ImageRemote _remote;

  Future<String> uploadImage({
    required String orgId,
    required String fileName,
    required Uint8List data,
  }) async {
    // e.g., check size < 5MB, type, etc.
    if (data.length > 5 * 1024 * 1024) throw Exception('File too large');
    return _remote.uploadImage(orgId: orgId, fileName: fileName, data: data);
  }

  Future<void> deleteImage({required String orgId, required String fileName}) =>
      _remote.deleteImage(orgId: orgId, fileName: fileName);

  Future<String> getImageUrl({
    required String orgId,
    required String fileName,
  }) => _remote.getImageUrl(orgId: orgId, fileName: fileName);
}
