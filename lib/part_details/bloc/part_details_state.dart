import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'part_details_state.freezed.dart';

enum PartDetailsStatus { idle, loading, done }

@freezed
abstract class PartDetailsState with _$PartDetailsState {
  const factory PartDetailsState({
    required PartPresentation part,
    @Default(PartDetailsStatus.idle) PartDetailsStatus stockStatus,
    @Default(PartDetailsStatus.idle) PartDetailsStatus deleteStatus,
    @Default(PartDetailsStatus.idle) PartDetailsStatus imageStatus,
    @Default([]) List<Storage> storages,
    Exception? error,
  }) = _PartDetailsState;
  const PartDetailsState._();

  bool get imageStatusLoading => imageStatus == .loading;
}
