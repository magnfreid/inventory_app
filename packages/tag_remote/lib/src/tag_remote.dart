import 'package:tag_remote/tag_remote.dart';

abstract interface class TagRemote {
  Stream<List<TagDto>> watchTags();
  Future<TagDto> addTag(TagCreateDto tag);
  Future<void> deleteTag(String id);
}
