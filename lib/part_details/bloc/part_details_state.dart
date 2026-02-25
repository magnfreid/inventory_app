import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_state.freezed.dart';

enum PartDetailsStatus { loading, loaded, success }

enum PartDetailsSaveStatus { idle, loading, success, error }

@freezed
abstract class PartDetailsState with _$PartDetailsState {
  const factory PartDetailsState({
    @Default(PartDetailsStatus.loading) PartDetailsStatus status,
    @Default(PartDetailsSaveStatus.idle) PartDetailsSaveStatus saveStatus,
    @Default([]) List<Storage> storages,
    @Default(false) bool showAddView,
  }) = _PartDetailsState;
  const PartDetailsState._();
}
