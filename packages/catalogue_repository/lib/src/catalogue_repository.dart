import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:catalogue_repository/src/models/catalogue_item.dart';

abstract interface class CatalogueRepository {
  Stream<List<CatalogueItem>> watchCatalogueItems();
  Future<void> addCatalogueItem({required CatalogueItemCreate item});
  Future<void> removeCatalogueItem({required String id});
  Future<void> updateCatalogueItem({required CatalogueItem item});
}
