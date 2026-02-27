import 'package:tag_remote/tag_remote.dart';

abstract interface class TagRemote {
  Stream<List<TagDto>> watchMainTags();
  Future<TagDto> addMainTag(TagCreateDto tag);
  Future<void> deleteMainTag(String id);
}
