import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/tags/models/tag_ui_model.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

part 'part_editor_event.dart';

class PartEditorBloc extends Bloc<PartEditorEvent, PartEditorState> {
  PartEditorBloc({
    required StockRepository stockRepository,
    required StorageRepository storageRepository,
    required PartRepository partRepository,
    required TagRepository tagRepository,
  }) : _stockRepository = stockRepository,
       _storageRepository = storageRepository,
       _partRepository = partRepository,
       _tagRepository = tagRepository,
       super(const PartEditorState()) {
    on<SaveButtonPressed>(_onSaveButtonPressed);
    on<_TagsUpdated>(_onTagsUpdated);

    _subscription = _tagRepository.watchAllTags().listen(
      (tags) => add(
        _TagsUpdated(tags: tags.map(TagUiModel.fromDomainModel).toList()),
      ),
    );
  }

  final StockRepository _stockRepository;
  final StorageRepository _storageRepository;
  final PartRepository _partRepository;
  final TagRepository _tagRepository;
  late final StreamSubscription<List<Tag>> _subscription;

  FutureOr<void> _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<PartEditorState> emit,
  ) async {
    final id = event.part.id;
    if (id != null) {
      emit(state.copyWith(status: .loading));
      try {
        await _partRepository.editPart(event.part);
        emit(state.copyWith(status: .success));
      } on Exception catch (exception) {
        emit(state.copyWith(status: .error));
      }
    } else {
      emit(state.copyWith(status: .loading));
      try {
        await _partRepository.addPart(event.part);
        emit(state.copyWith(status: .success));
      } on Exception catch (_) {
        emit(state.copyWith(status: .error));
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
}
