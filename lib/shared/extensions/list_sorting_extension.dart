import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

extension TagSorting on List<TagPresentation> {
  List<TagPresentation> sortedByLabel() =>
      [...this]..sort((a, b) => a.label.compareTo(b.label));
}

extension StorageSorting on List<Storage> {
  List<Storage> sortedByName() =>
      [...this]..sort((a, b) => a.name.compareTo(b.name));
}

extension SortBy on List<PartPresentation> {
  /// Sorts this list by [type]. Pass [ascending] false to reverse the order
  /// without allocating a second list.
  void sortBy(SortByType type, {bool ascending = true}) {
    final sign = ascending ? 1 : -1;
    switch (type) {
      case .name:
        sort((a, b) => sign * a.name.compareTo(b.name));
      case .brand:
        sort(
          (a, b) => sign *
              (a.brandTag?.label ?? '').compareTo(b.brandTag?.label ?? ''),
        );
      case .category:
        sort(
          (a, b) => sign *
              (a.categoryTag?.label ?? '')
                  .compareTo(b.categoryTag?.label ?? ''),
        );
      case .quantity:
        sort((a, b) => sign * a.totalQuantity.compareTo(b.totalQuantity));
    }
  }
}
