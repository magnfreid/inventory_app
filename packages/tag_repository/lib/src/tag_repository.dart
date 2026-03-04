import 'package:rxdart/rxdart.dart';
import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/tag_repository.dart';

class TagRepository {
  TagRepository({required TagRemote remote}) : _remote = remote;

  final TagRemote _remote;

  late final Stream<List<Tag>> _allTagsStream = _remote
      .watchTags()
      .map((dtos) => dtos.map(Tag.fromDto).toList())
      .shareReplay(maxSize: 1);

  Stream<List<Tag>> watchTags() => _allTagsStream;

  Future<Tag> addTag(Tag tag) async {
    final dto = tag.toDto();
    final createdDto = await _remote.addTag(dto);
    return Tag.fromDto(createdDto);
  }
}
