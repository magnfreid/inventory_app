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

  Stream<List<Tag>> watchAllTags() => _allTagsStream;
  Stream<List<Tag>> watchBrandTags() => _allTagsStream.map(
    (tags) => tags.where((tag) => tag.type == .brand).toList(),
  );
  Stream<List<Tag>> watchCategoryTags() => _allTagsStream.map(
    (tags) => tags.where((tag) => tag.type == .category).toList(),
  );
  Stream<List<Tag>> watchGeneralTags() => _allTagsStream.map(
    (tags) => tags.where((tag) => tag.type == .general).toList(),
  );

  Future<Tag> addTag(TagCreate tag) async {
    final dto = tag.toDto();
    final createdDto = await _remote.addTag(dto);
    return Tag.fromDto(createdDto);
  }
}
