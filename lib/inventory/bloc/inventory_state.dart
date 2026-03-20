import 'package:core_remote/core_remote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'inventory_state.freezed.dart';

enum InventoryStateStatus { loading, loaded }

enum InventoryStateBottomSheetStatus { idle, loading, done }

@freezed
abstract class InventoryState with _$InventoryState {
  const factory InventoryState({
    @Default(InventoryStateStatus.loading) InventoryStateStatus status,
    @Default([]) List<PartPresentation> parts,
    @Default(InventoryFilter()) InventoryFilter filter,
    @Default([]) List<TagPresentation> brandTags,
    @Default([]) List<TagPresentation> categoryTags,
    @Default([]) List<Storage> storages,
    @Default(InventoryStateBottomSheetStatus.idle)
    InventoryStateBottomSheetStatus bottomSheetStatus,
    Exception? error,
  }) = _InventoryState;
  const InventoryState._();

  bool get isLoading => status == .loading;
  bool get hasError => error != null;
  bool get isLoadingBottomSheet => bottomSheetStatus == .loading;
}
