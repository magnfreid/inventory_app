import 'package:inventory_repository/inventory_repository.dart';

abstract interface class InventoryRepository {
  Stream<List<InventoryItem>> watchInventoryItems();
  Future<void> increaseStock({
    required String productId,
    required String locationId,
    required int amount,
  });
  Future<void> decreaseStock({
    required String productId,
    required String locationId,
    required int amount,
  });
}
