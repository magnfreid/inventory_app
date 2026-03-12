import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:tag_repository/tag_repository.dart';

part 'tags_event.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc({required TagRepository tagRepository})
    : _tagRepository = tagRepository,
      super(const TagsState()) {
    on<_TagsUpdated>(_onTagsUpdated);
    on<SaveButtonPressed>(_onSaveButtonPressed);

    _subscription = tagRepository.watchTags().listen(
      (tags) {
        final uiTags = tags.map(TagPresentation.fromDomainModel).toList();
        add(_TagsUpdated(tags: uiTags));
      },
    );
  }

  final TagRepository _tagRepository;
  late final StreamSubscription<List<Tag>> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _onTagsUpdated(_TagsUpdated event, Emitter<TagsState> emit) {
    emit(
      state.copyWith(
        status: .loaded,
        brandTags: event.tags.where((tag) => tag.type == .brand).toList(),
        categoryTags: event.tags.where((tag) => tag.type == .category).toList(),
        generalTags: event.tags.where((tag) => tag.type == .general).toList(),
      ),
    );
  }

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<TagsState> emit,
  ) async {
    final tag = event.tag;
    emit(state.copyWith(bottomSheetStatus: .loading));
    try {
      if (tag.id == null) {
        await _tagRepository.addTag(tag);
      } else {
        await _tagRepository.editTag(tag);
      }
      emit(state.copyWith(bottomSheetStatus: .success));
    } on Exception catch (_) {
      emit(state.copyWith(bottomSheetStatus: .idle));
    }
  }
}
