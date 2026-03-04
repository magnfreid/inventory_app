import 'package:rxdart/rxdart.dart';
import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/tag_repository.dart';

/// Repository for managing [Tag]s using a [TagRemote] data source.
class TagRepository {
  /// Creates a [TagRepository] with the given [remote] data source.
  TagRepository({required TagRemote remote}) : _remote = remote;

  final TagRemote _remote;

  late final Stream<List<Tag>> _allTagsStream = _remote
      .watchTags()
      .map((dtos) => dtos.map(Tag.fromDto).toList())
      .shareReplay(maxSize: 1);

  /// Watches all tags as a stream of domain [Tag]s.
  ///
  /// New subscribers will immediately receive the latest list due to caching.
  Stream<List<Tag>> watchTags() => _allTagsStream;

  /// Adds a [tag] via the remote and returns the created [Tag] with ID.
  Future<Tag> addTag(Tag tag) async {
    final dto = tag.toDto();
    final createdDto = await _remote.addTag(dto);
    return Tag.fromDto(createdDto);
  }
}
