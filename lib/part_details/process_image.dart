import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

typedef ProcessedImages = ({Uint8List full, Uint8List thumbnail});

ProcessedImages processImage(Uint8List bytes) {
  final image = img.decodeImage(bytes);
  if (image == null) throw Exception('Failed to decode image');

  final oriented = img.bakeOrientation(image);

  const fullWidth = 1080;
  const fullHeight = 608;
  const thumbWidth = 300;
  const thumbHeight = 169;

  final full = img.copyResize(
    oriented,
    width: fullWidth,
    height: fullHeight,
    interpolation: img.Interpolation.cubic,
  );

  final thumbnail = img.copyResize(
    oriented,
    width: thumbWidth,
    height: thumbHeight,
    interpolation: img.Interpolation.cubic,
  );

  return (
    full: Uint8List.fromList(img.encodeJpg(full, quality: 85)),
    thumbnail: Uint8List.fromList(img.encodeJpg(thumbnail, quality: 80)),
  );
}
