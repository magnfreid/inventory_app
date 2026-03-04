import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_state.freezed.dart';

enum PartDetailsStatus { loading, loaded }

// enum PartDetailsSaveStatus { idle, loading, success, error }

@freezed
abstract class PartDetailsState with _$PartDetailsState {
  const factory PartDetailsState({
    @Default(PartDetailsStatus.loading) PartDetailsStatus status,
    PartPresentation? part,
    // @Default(PartDetailsSaveStatus.idle) PartDetailsSaveStatus saveStatus,
    // @Default([]) List<Storage> storages,
    // @Default(false) bool showAddView,
  }) = _PartDetailsState;
  const PartDetailsState._();
}
