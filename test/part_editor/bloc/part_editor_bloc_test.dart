import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:tag_repository/tag_repository.dart';

import '../../helpers/mocks.dart';

void main() {
  late PartRepository partRepository;
  late TagRepository tagRepository;
  late StreamController<List<Tag>> streamController;
  late Part newPart;
  late Part existingPart;
  late Tag brandTag;
  late Tag categoryTag;
  late Tag generalTag;
  late Exception error;

  setUp(() {
    partRepository = MockPartRepository();
    tagRepository = MockTagRepository();
    streamController = StreamController();
    newPart = const Part(
      id: null,
      name: 'New',
      detailNumber: 'detailNumber',
      price: 10,
      isRecycled: true,
      brandTagId: null,
      categoryTagId: null,
      generalTagIds: [],
      description: null,
      imgPath: 'imgPath',
    );
    existingPart = const Part(
      id: '123',
      name: 'Existing',
      detailNumber: 'detailNumber',
      price: 10,
      isRecycled: true,
      brandTagId: null,
      categoryTagId: null,
      generalTagIds: [],
      description: null,
      imgPath: 'imgPath',
    );

    brandTag = Tag(id: '123', label: 'Brand', color: .amber, type: .brand);
    categoryTag = Tag(
      id: '456',
      label: 'Category',
      color: .blue,
      type: .category,
    );
    generalTag = Tag(
      id: '789',
      label: 'General',
      color: .crimson,
      type: .general,
    );
    error = Exception('Fail');

    when(
      () => tagRepository.watchTags(),
    ).thenAnswer((_) => streamController.stream);
    when(
      () => partRepository.addPart(newPart),
    ).thenAnswer((_) async => Future.value(newPart));
    when(
      () => partRepository.editPart(existingPart),
    ).thenAnswer((_) async => Future.value(existingPart));
  });

  group('PartEditorBloc', () {
    test('inital state', () {
      final bloc = PartEditorBloc(
        partRepository: partRepository,
        tagRepository: tagRepository,
      );

      expect(bloc.state, const PartEditorState());
    });

    blocTest(
      'emits [loading, success] when SaveButtonPressed is added, part is new '
      'and save is successful',
      build: () {
        return PartEditorBloc(
          partRepository: partRepository,
          tagRepository: tagRepository,
        );
      },
      act: (bloc) => bloc.add(SaveButtonPressed(part: newPart)),
      expect: () => [
        isA<PartEditorState>().having(
          (s) => s.status,
          'status',
          PartEditorStatus.loading,
        ),
        isA<PartEditorState>().having(
          (s) => s.status,
          'status',
          PartEditorStatus.done,
        ),
      ],
      verify: (_) {
        verify(() => partRepository.addPart(newPart)).called(1);
        verifyNever(() => partRepository.editPart(newPart));
      },
    );

    blocTest(
      'emits [loading, success] when SaveButtonPressed is added, part is '
      'existing and save is successful',
      build: () {
        return PartEditorBloc(
          partRepository: partRepository,
          tagRepository: tagRepository,
        );
      },
      act: (bloc) => bloc.add(SaveButtonPressed(part: existingPart)),
      expect: () => [
        isA<PartEditorState>().having(
          (s) => s.status,
          'status',
          PartEditorStatus.loading,
        ),
        isA<PartEditorState>().having(
          (s) => s.status,
          'status',
          PartEditorStatus.done,
        ),
      ],
      verify: (_) {
        verify(() => partRepository.editPart(existingPart)).called(1);
        verifyNever(() => partRepository.addPart(existingPart));
      },
    );

    blocTest(
      'emits [loading, done] and error when SaveButtonPressed is added, part '
      'is new and save fails',
      build: () {
        when(
          () => partRepository.addPart(newPart),
        ).thenThrow(error);
        return PartEditorBloc(
          partRepository: partRepository,
          tagRepository: tagRepository,
        );
      },
      act: (bloc) => bloc.add(SaveButtonPressed(part: newPart)),
      expect: () => [
        isA<PartEditorState>()
            .having(
              (s) => s.status,
              'status',
              PartEditorStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartEditorState>()
            .having(
              (s) => s.status,
              'status',
              PartEditorStatus.idle,
            )
            .having((s) => s.error, 'error', error),
      ],
    );

    blocTest(
      'emits [loading, done] and error when SaveButtonPressed is added, part '
      'is existing and save fails',
      build: () {
        when(
          () => partRepository.editPart(existingPart),
        ).thenThrow(error);
        return PartEditorBloc(
          partRepository: partRepository,
          tagRepository: tagRepository,
        );
      },
      act: (bloc) => bloc.add(SaveButtonPressed(part: existingPart)),
      expect: () => [
        isA<PartEditorState>()
            .having(
              (s) => s.status,
              'status',
              PartEditorStatus.loading,
            )
            .having((s) => s.error, 'error', isNull),
        isA<PartEditorState>()
            .having(
              (s) => s.status,
              'status',
              PartEditorStatus.idle,
            )
            .having((s) => s.error, 'error', error),
      ],
    );

    blocTest(
      'emits correct tags when TagsUpdated is added',
      build: () {
        return PartEditorBloc(
          partRepository: partRepository,
          tagRepository: tagRepository,
        );
      },
      act: (_) => streamController.add([brandTag, categoryTag, generalTag]),
      expect: () => [
        isA<PartEditorState>()
            .having(
              (s) => s.status,
              'status',
              PartEditorStatus.idle,
            )
            .having(
              (s) => s.brandTags,
              'brandTags',
              contains(
                isA<TagPresentation>().having(
                  (tag) => tag.type,
                  'type',
                  TagType.brand,
                ),
              ),
            )
            .having(
              (s) => s.categoryTags,
              'categoryTags',
              contains(
                isA<TagPresentation>().having(
                  (tag) => tag.type,
                  'type',
                  TagType.category,
                ),
              ),
            )
            .having(
              (s) => s.generalTags,
              'generalTags',
              contains(
                isA<TagPresentation>().having(
                  (tag) => tag.type,
                  'type',
                  TagType.general,
                ),
              ),
            ),
      ],
    );
  });
}
