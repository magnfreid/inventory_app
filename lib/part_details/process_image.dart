import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

Uint8List processImage(Uint8List bytes) {
  final image = img.decodeImage(bytes);
  if (image == null) throw Exception('Failed to decode image');

  final oriented = img.bakeOrientation(image);

  const targetWidth = 1080;
  const targetHeight = 608;

  final resized = img.copyResize(
    oriented,
    width: targetWidth,
    height: targetHeight,
    interpolation: img.Interpolation.cubic,
  );

  return Uint8List.fromList(img.encodeJpg(resized, quality: 85));
}
