import 'package:catalogue_repository/src/models/catalogue_item.dart';

abstract interface class CatalogueRepository {
  Stream<List<CatalogueItem>> watchCatalogueItems();
  Future<void> addCatalogueItem({required CatalogueItem item});
  Future<void> removeCatalogueItem({required String id});
  Future<void> updateCatalogueItem({required CatalogueItem item});
}
