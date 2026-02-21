import 'package:inventory_repository/inventory_repository.dart';

abstract interface class InventoryRepository {
  Stream<List<InventoryItem>> watchInventoryItems();
}
