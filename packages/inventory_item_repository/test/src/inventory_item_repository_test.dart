// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_item_repository/inventory_item_repository.dart';

void main() {
  group('InventoryItemRepository', () {
    test('can be instantiated', () {
      expect(InventoryItemRepository(), isNotNull);
    });
  });
}
