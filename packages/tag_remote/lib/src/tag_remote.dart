import 'package:tag_remote/tag_remote.dart';

///Interface for [TagDto] remote data source.
abstract interface class TagRemote {
  ///Returns a [Stream] of a [List] of [TagDto]
  Stream<List<TagDto>> watchTags();

  ///Adds a new [TagDto] to the remote data source.
  Future<TagDto> addTag(TagDto tag);

  ///Deletes a [TagDto] from the remote data source.
  Future<void> deleteTag(String id);

  ///Edit an existing [TagDto] on the remote data source.
  Future<void> editTag(TagDto tag);
}
