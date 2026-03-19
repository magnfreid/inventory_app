import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_state.freezed.dart';

enum PartDetailsContent { details, inStock, restock }

enum PartDetailsSaveStatus { idle, loading, done }

enum PartDetailsDeleteStatus { idle, loading, done }

@freezed
abstract class PartDetailsState with _$PartDetailsState {
  const factory PartDetailsState({
    @Default(PartDetailsContent.details) PartDetailsContent content,
    @Default(PartDetailsSaveStatus.idle) PartDetailsSaveStatus saveStatus,
    @Default(PartDetailsDeleteStatus.idle) PartDetailsDeleteStatus deleteStatus,
    @Default([]) List<Storage> storages,
    PartPresentation? part,
    Exception? error,
  }) = _PartDetailsState;
  const PartDetailsState._();

  bool get isLoading => part == null;
}
