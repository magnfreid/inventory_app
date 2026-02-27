import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/tag_repository.dart';

class TagRepository {
  const TagRepository({required TagRemote remote}) : _remote = remote;

  final TagRemote _remote;

  Stream<List<Tag>> watchMainTags() =>
      _remote.watchMainTags().map((dtos) => dtos.map(Tag.fromDto).toList());

  Future<Tag> addMainTag(TagCreate tag) async {
    final dto = tag.toDto();
    final createdDto = await _remote.addMainTag(dto);
    return Tag.fromDto(createdDto);
  }
}
