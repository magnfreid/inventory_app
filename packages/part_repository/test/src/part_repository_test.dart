import 'package:mocktail/mocktail.dart';
import 'package:part_remote/part_remote.dart';
import 'package:part_repository/part_repository.dart';
import 'package:test/test.dart';

class MockPartRemote extends Mock implements PartRemote {}

void main() {
  late MockPartRemote mockRemote;
  late PartRepository repository;
  late PartDto dto;
  late Part domainPart;

  setUp(() {
    mockRemote = MockPartRemote();
    repository = PartRepository(remote: mockRemote);

    dto = PartDto(
      id: 'abc',
      name: 'Test Part',
      detailNumber: '123',
      isRecycled: false,
      price: 10,
      categoryTagId: '',
      description: '',
      brandTagId: '',
      generalTagIds: [],
      imgPath: 'path',
    );

    domainPart = Part.fromDto(dto);
  });

  setUpAll(() {
    registerFallbackValue(
      PartDto(
        id: 'fallback',
        name: '',
        detailNumber: '',
        isRecycled: false,
        price: 0,
        categoryTagId: '',
        description: '',
        brandTagId: '',
        generalTagIds: [],
        imgPath: '',
      ),
    );
  });

  test('watchParts maps DTOs to domain models', () async {
    when(() => mockRemote.watchParts()).thenAnswer((_) => Stream.value([dto]));

    final parts = await repository.watchParts().first;

    expect(parts.first.id, dto.id);
    expect(parts.first.name, dto.name);
  });

  test('addPart calls remote and returns domain model', () async {
    when(() => mockRemote.addPart(any())).thenAnswer((_) async => dto);

    final result = await repository.addPart(domainPart);

    verify(() => mockRemote.addPart(any())).called(1);
    expect(result.id, dto.id);
    expect(result.name, dto.name);
  });

  test('editPart calls remote with correct DTO', () async {
    when(() => mockRemote.editPart(any())).thenAnswer((_) async => dto);

    await repository.editPart(domainPart);

    verify(() => mockRemote.editPart(any())).called(1);
  });
}
