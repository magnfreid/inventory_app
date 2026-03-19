import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core_remote/core_remote.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/shared/utilities/bloc_transformers.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:tag_repository/tag_repository.dart';

part 'part_editor_event.dart';

class PartEditorBloc extends Bloc<PartEditorEvent, PartEditorState> {
  PartEditorBloc({
    required PartRepository partRepository,
    required TagRepository tagRepository,
  }) : _partRepository = partRepository,
       _tagRepository = tagRepository,
       super(const PartEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed);
    on<_TagsUpdated>(
      _onTagsUpdated,
      transformer: debounceRestartable(const Duration(milliseconds: 500)),
    );
    on<_OnStreamError>(_onStreamError);

    _subscription = _tagRepository.watchTags().listen(
      (tags) => add(
        _TagsUpdated(tags: tags.map(TagPresentation.fromDomainModel).toList()),
      ),
      onError: _handleStreamError,
    );
  }

  final PartRepository _partRepository;
  final TagRepository _tagRepository;
  late final StreamSubscription<List<Tag>> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<PartEditorState> emit,
  ) async {
    final id = event.part.id;
    if (id != null) {
      emit(state.copyWith(status: .loading, error: null));
      try {
        await _partRepository.editPart(event.part);
        emit(state.copyWith(status: .done));
      } on Exception catch (e) {
        emit(state.copyWith(status: .idle, error: e));
      }
    } else {
      emit(state.copyWith(status: .loading));
      try {
        await _partRepository.addPart(event.part);
        emit(state.copyWith(status: .done));
      } on Exception catch (e) {
        emit(state.copyWith(status: .idle, error: e));
      }
    }
  }

  FutureOr<void> _onTagsUpdated(
    _TagsUpdated event,
    Emitter<PartEditorState> emit,
  ) {
    final brandTags = event.tags.where((tag) => tag.type == .brand).toList();
    final categoryTags = event.tags
        .where((tag) => tag.type == .category)
        .toList();
    final generalTags = event.tags
        .where((tag) => tag.type == .general)
        .toList();
    emit(
      state.copyWith(
        brandTags: brandTags,
        categoryTags: categoryTags,
        generalTags: generalTags,
      ),
    );
  }

  void _handleStreamError(dynamic e) {
    final error = (e is RemoteException) ? e : const UnknownRemoteException();
    add(_OnStreamError(error: error));
  }

  FutureOr<void> _onStreamError(
    _OnStreamError event,
    Emitter<PartEditorState> emit,
  ) {
    emit(state.copyWith(error: event.error));
  }
}
