import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:tag_repository/tag_repository.dart';

part 'tags_event.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc({required TagRepository tagRepository})
    : _tagRepository = tagRepository,
      super(const TagsState()) {
    on<_TagsUpdated>(_onTagsUpdated);
    on<SaveButtonPressed>(_onSaveButtonPressed);

    _subscription = tagRepository.watchMainTags().listen(
      (tags) => add(_TagsUpdated(tags: tags)),
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
    emit(state.copyWith(status: .loaded, tags: event.tags));
  }

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<TagsState> emit,
  ) async {
    emit(state.copyWith(bottomSheetStatus: .loading));
    try {
      await _tagRepository.addMainTag(event.tag);
      emit(state.copyWith(bottomSheetStatus: .success));
    } on Exception catch (exception) {
      emit(state.copyWith(bottomSheetStatus: .idle));
    }
  }
}
