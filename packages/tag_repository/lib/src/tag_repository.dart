import 'package:rxdart/rxdart.dart';
import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/tag_repository.dart';

class TagRepository {
  TagRepository({required TagRemote remote}) : _remote = remote;

  final TagRemote _remote;

  late final Stream<List<Tag>> _mainTagsStream = _remote
      .watchMainTags()
      .map((dtos) => dtos.map(Tag.fromDto).toList())
      .shareReplay(maxSize: 1);

  Stream<List<Tag>> watchMainTags() => _mainTagsStream;

  Future<Tag> addMainTag(TagCreate tag) async {
    final dto = tag.toDto();
    final createdDto = await _remote.addMainTag(dto);
    return Tag.fromDto(createdDto);
  }
}
