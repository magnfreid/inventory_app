import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:core_remote/core_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tag_repository/tag_repository.dart';

class MockTagRepository extends Mock implements TagRepository {}

Tag _makeTag({
  String? id = 't1',
  String label = 'Test',
  TagColor color = TagColor.blue,
  TagType type = TagType.general,
}) =>
    Tag(id: id, label: label, color: color, type: type);

void main() {
  late MockTagRepository mockRepo;
  late StreamController<List<Tag>> tagController;

  setUpAll(() {
    registerFallbackValue(_makeTag());
  });

  setUp(() {
    mockRepo = MockTagRepository();
    tagController = StreamController<List<Tag>>();

    when(() => mockRepo.watchTags()).thenAnswer((_) => tagController.stream);
  });

  tearDown(() async {
    await tagController.close();
  });

  group('TagsBloc', () {
    blocTest<TagsBloc, TagsState>(
      'initial state is loading with empty tag lists',
      build: () => TagsBloc(tagRepository: mockRepo),
      expect: () => [],
      verify: (bloc) {
        expect(bloc.state.status, TagsStateStatus.loading);
        expect(bloc.state.brandTags, isEmpty);
        expect(bloc.state.categoryTags, isEmpty);
        expect(bloc.state.generalTags, isEmpty);
      },
    );

    blocTest<TagsBloc, TagsState>(
      'emits loaded and sorted tags when stream emits',
      build: () => TagsBloc(tagRepository: mockRepo),
      act: (bloc) {
        tagController.add([
          _makeTag(id: 'b1', label: 'Nike', type: TagType.brand),
          _makeTag(id: 'c1', label: 'Electronics', type: TagType.category),
          _makeTag(id: 'g1', label: 'Urgent', type: TagType.general),
        ]);
      },
      expect: () => [
        isA<TagsState>()
            .having((s) => s.status, 'status', TagsStateStatus.loaded)
            .having((s) => s.brandTags.length, 'brandTags', 1)
            .having((s) => s.categoryTags.length, 'categoryTags', 1)
            .having((s) => s.generalTags.length, 'generalTags', 1),
      ],
    );

    blocTest<TagsBloc, TagsState>(
      'SaveButtonPressed with no id calls addTag',
      build: () {
        when(() => mockRepo.addTag(any())).thenAnswer((_) async => _makeTag());
        return TagsBloc(tagRepository: mockRepo);
      },
      act: (bloc) {
        bloc.add(SaveButtonPressed(tag: _makeTag(id: null)));
      },
      wait: const Duration(milliseconds: 600),
      verify: (_) {
        verify(() => mockRepo.addTag(any())).called(1);
      },
    );

    blocTest<TagsBloc, TagsState>(
      'SaveButtonPressed with id calls editTag',
      build: () {
        when(() => mockRepo.editTag(any())).thenAnswer((_) async {});
        return TagsBloc(tagRepository: mockRepo);
      },
      act: (bloc) {
        bloc.add(SaveButtonPressed(tag: _makeTag(id: 'existing-id')));
      },
      wait: const Duration(milliseconds: 600),
      verify: (_) {
        verify(() => mockRepo.editTag(any())).called(1);
      },
    );

    blocTest<TagsBloc, TagsState>(
      'SaveButtonPressed emits loading then done on success',
      build: () {
        when(() => mockRepo.addTag(any())).thenAnswer((_) async => _makeTag());
        return TagsBloc(tagRepository: mockRepo);
      },
      act: (bloc) {
        bloc.add(SaveButtonPressed(tag: _makeTag(id: null)));
      },
      wait: const Duration(milliseconds: 600),
      expect: () => [
        isA<TagsState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          TagsStateBottomSheetStatus.loading,
        ),
        isA<TagsState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          TagsStateBottomSheetStatus.done,
        ),
      ],
    );

    blocTest<TagsBloc, TagsState>(
      'SaveButtonPressed emits done with error when addTag throws',
      build: () {
        when(
          () => mockRepo.addTag(any()),
        ).thenThrow(Exception('network error'));
        return TagsBloc(tagRepository: mockRepo);
      },
      act: (bloc) {
        bloc.add(SaveButtonPressed(tag: _makeTag(id: null)));
      },
      wait: const Duration(milliseconds: 600),
      expect: () => [
        isA<TagsState>().having(
          (s) => s.bottomSheetStatus,
          'bottomSheetStatus',
          TagsStateBottomSheetStatus.loading,
        ),
        isA<TagsState>()
            .having(
              (s) => s.bottomSheetStatus,
              'bottomSheetStatus',
              TagsStateBottomSheetStatus.done,
            )
            .having((s) => s.error, 'error', isNotNull),
      ],
    );

    blocTest<TagsBloc, TagsState>(
      'stream error emits state with error',
      build: () => TagsBloc(tagRepository: mockRepo),
      act: (bloc) {
        tagController.addError(const UnknownRemoteException());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<TagsState>().having((s) => s.error, 'error', isNotNull),
      ],
    );

    blocTest<TagsBloc, TagsState>(
      'stream error wraps non-RemoteException into UnknownRemoteException',
      build: () => TagsBloc(tagRepository: mockRepo),
      act: (bloc) {
        tagController.addError(Exception('unknown'));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<TagsState>().having(
          (s) => s.error,
          'error',
          isA<UnknownRemoteException>(),
        ),
      ],
    );
  });
}
