import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

part 'inventory_state.freezed.dart';

enum InventoryStateStatus { loading, loaded }

enum InventoryStateBottomSheetStatus { idle, loading, success, error }

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
  }) = _InventoryState;
  const InventoryState._();

  bool get isLoading => status == .loading;
  bool get isLoadingBottomSheet => bottomSheetStatus == .loading;
  List<PartPresentation> get filteredParts {
    return parts.where((part) {
      if (filter.quantityFilter == .inStock && part.totalQuantity == 0) {
        return false;
      }

      if (filter.quantityFilter == .outOfStock && part.totalQuantity > 0) {
        return false;
      }

      if (filter.brandFilters.isNotEmpty &&
          !filter.brandFilters.contains(part.brandTag?.id)) {
        return false;
      }

      if (filter.categoryFilters.isNotEmpty &&
          !filter.categoryFilters.contains(part.categoryTag?.id)) {
        return false;
      }

      if (filter.storageFilters.isNotEmpty &&
          !part.stock.any(
            (stock) => filter.storageFilters.any(
              (id) => id == stock.storageId && stock.quantity > 0,
            ),
          )) {
        return false;
      }

      return true;
    }).toList();
  }
}
