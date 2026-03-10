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
  void sortBy(SortByType type) => switch (type) {
    .name => sort((a, b) => a.name.compareTo(b.name)),
    .brand => sort(
      (a, b) => (a.brandTag?.label ?? '').compareTo(b.brandTag?.label ?? ''),
    ),
    .category => sort(
      (a, b) =>
          (a.categoryTag?.label ?? '').compareTo(b.categoryTag?.label ?? ''),
    ),
    .quantity => sort((a, b) => a.totalQuantity.compareTo(b.totalQuantity)),
  };
}
