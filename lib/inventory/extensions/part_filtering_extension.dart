import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';

extension PartFiltering on InventoryState {
  List<PartPresentation> get filteredParts {
    final query = filter.searchQuery.toLowerCase();

    if (query.isNotEmpty) {
      return parts.where((part) {
        final matchesName = part.name.toLowerCase().contains(query);
        final matchesDetail = part.detailNumber.toLowerCase().contains(query);
        final matchesBrand =
            part.brandTag?.label.toLowerCase().contains(query) ?? false;
        final matchesCategory =
            part.categoryTag?.label.toLowerCase().contains(query) ?? false;

        return matchesName || matchesDetail || matchesBrand || matchesCategory;
      }).toList();
    }

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
