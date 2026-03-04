import 'package:tag_remote/tag_remote.dart';

abstract interface class TagRemote {
  Stream<List<TagDto>> watchTags();
  Future<TagDto> addTag(TagDto tag);
  Future<void> deleteTag(String id);
  Future<void> editTag(TagDto tag);
}
