import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/tag_repository.dart';

class MockTagRemote extends Mock implements TagRemote {}

void main() {
  late MockTagRemote mockRemote;
  late TagRepository repository;
  late TagDto dto;
  late Tag domainTag;

  setUpAll(() {
    registerFallbackValue(
      TagDto(id: 'fallback', label: '', color: '', type: ''),
    );
  });

  setUp(() {
    mockRemote = MockTagRemote();
    repository = TagRepository(remote: mockRemote);

    dto = TagDto(id: 't1', label: 'Urgent', color: 'red', type: 'general');
    domainTag = Tag.fromDto(dto);
  });

  test('watchTags maps DTOs to domain models', () async {
    when(() => mockRemote.watchTags()).thenAnswer((_) => Stream.value([dto]));

    final tags = await repository.watchTags().first;

    expect(tags.first.id, dto.id);
    expect(tags.first.label, dto.label);
    expect(tags.first.color.name, domainTag.color.name);
    expect(tags.first.type.name, domainTag.type.name);
  });

  test('addTag calls remote and returns domain model', () async {
    when(() => mockRemote.addTag(any())).thenAnswer((_) async => dto);

    final result = await repository.addTag(domainTag);

    final captured = verify(() => mockRemote.addTag(captureAny())).captured;
    final capturedDto = captured.first as TagDto;
    expect(capturedDto.label, domainTag.label);
    expect(capturedDto.color, domainTag.color.name);
    expect(capturedDto.type, domainTag.type.name);

    expect(result.id, dto.id);
    expect(result.label, dto.label);
    expect(result.color.name, domainTag.color.name);
    expect(result.type.name, domainTag.type.name);
  });
}
