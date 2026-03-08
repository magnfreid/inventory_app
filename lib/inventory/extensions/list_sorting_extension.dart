import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:storage_repository/storage_repository.dart';

extension TagSorting on List<TagPresentation> {
  List<TagPresentation> sortedByLabel() =>
      [...this]..sort((a, b) => a.label.compareTo(b.label));
}

extension StorageSorting on List<Storage> {
  List<Storage> sortedByName() =>
      [...this]..sort((a, b) => a.name.compareTo(b.name));
}
