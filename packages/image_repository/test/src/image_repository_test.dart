import 'package:image_repository/image_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ImageRepository', () {
    test('can be instantiated', () {
      expect(ImageRepository(), isNotNull);
    });
  });
}
